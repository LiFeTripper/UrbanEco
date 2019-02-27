using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using UrbanEco.Rapports;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using System.Diagnostics;

namespace UrbanEco
{
    public partial class RapportPage : System.Web.UI.Page
    {

        [DllImport("user32.dll", SetLastError = true)]
        static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            chercherRapport();

            bool isExcelInstalled = Type.GetTypeFromProgID("Excel.Application") != null ? true : false;

            btn_excel.Visible = isExcelInstalled;

        }

        private void chercherRapport()
        {
            RapportNode rapportNode = (RapportNode)Session["rapportNode"];
            tbx_dateDebut.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateDebut"]);
            tbx_dateFin.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateFin"]);

            if (rapportNode != null)
            {
                rapportRepeater.DataSource = rapportNode.Child;
                rapportRepeater.DataBind();
            }
        }

        public string formatHeure(object p_nbHeure)
        {
            TimeSpan nbHeure = (TimeSpan)p_nbHeure;

            Console.WriteLine(nbHeure);

            int heure = nbHeure.Days * 24;
            heure += nbHeure.Hours;

            int minute = nbHeure.Minutes;

            return string.Format("{0} h {1}", heure, minute.ToString("00"));
        }

        public float formatHeureFloat(object p_nbHeure)
        {
            TimeSpan nbHeure = (TimeSpan)p_nbHeure;

            int heure = nbHeure.Days * 24;
            heure += nbHeure.Hours;

            int minute = nbHeure.Minutes;

            return heure + minute;
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            RapportNode rapportNode = (RapportNode)Session["rapportNode"];

            object misValue = System.Reflection.Missing.Value;


            //Excel
            Excel.Application xlApp = null;
            Excel.Workbook xlWorkBook = null;
            Excel.Worksheet xlWorkSheet = null;

            //File info
            string filename = "RapportProjet.xlsx";
            string directory = Server.MapPath("Excel/");
            string filepath = directory + filename;

            if (!Directory.Exists(directory))
                Directory.CreateDirectory(directory);

            bool ExcelGeneratedWithError = false;

            uint processId = 0;

            bool isExcelInstalled = Type.GetTypeFromProgID("Excel.Application") != null ? true : false;
            
            if(!isExcelInstalled)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Le serveur ne possède pas Excel.\nL'exportation en XLSX est donc impossible.";
                return;
            }


            try
            {
                //Open Excel
                xlApp = new Excel.Application();
                xlWorkBook = xlApp.Workbooks.Add(misValue);
                xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

                xlApp.Visible = false;

                int indexX = 1;

                GetWindowThreadProcessId(new IntPtr(xlApp.Hwnd), out processId);

                //Projet
                for (int x = 0; x < rapportNode.Child.Count; x++)
                {
                    var projet = rapportNode.Child[x];
                    xlWorkSheet.Cells[indexX, 1].Value = "Total de : " + projet.Nom;

                    xlWorkSheet.Cells[indexX, 4].Value = formatHeureFloat(projet.NbHeure).ToString();
                    indexX++;


                    //Sous-Catégorie
                    for (int y = 0; y < projet.Child.Count; y++)
                    {
                        var s_cat = projet.Child[y];
                        xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                        xlWorkSheet.Cells[indexX, 2].Value = "Total de : " + s_cat.Nom;
                        //xlWorkSheet.Cells[indexX, 3].Value = emp.Nom;
                        xlWorkSheet.Cells[indexX, 4].Value = formatHeureFloat(s_cat.NbHeure).ToString();
                        indexX++;


                        //Employé
                        for (int z = 0; z < s_cat.Child.Count; z++)
                        {
                            var emp = s_cat.Child[z];
                            xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                            xlWorkSheet.Cells[indexX, 2].Value = s_cat.Nom;
                            xlWorkSheet.Cells[indexX, 3].Value = emp.Nom;
                            xlWorkSheet.Cells[indexX, 4].Value = formatHeureFloat(emp.NbHeure).ToString();
                            indexX++;

                            //Feuille de temps
                            for (int a = 0; a < emp.Child.Count; a++)
                            {
                                var ft = emp.Child[a];

                                xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                                xlWorkSheet.Cells[indexX, 2].Value = s_cat.Nom;
                                xlWorkSheet.Cells[indexX, 3].Value = emp.Nom;
                                xlWorkSheet.Cells[indexX, 4].Value = formatHeureFloat(emp.NbHeure);
                                xlWorkSheet.Cells[indexX, 5].Value = ft.Nom;
                                xlWorkSheet.Cells[indexX, 6].Value = ft.Description;
                                xlWorkSheet.Cells[indexX, 7].Value = ft.NbHeure.ToString();
                                indexX++;
                            }
                        }
                    }
                }

                //Delete existing file
                if (File.Exists(filepath))
                {
                    File.Delete(filepath);
                }

                //Save file
                FileInfo info = new FileInfo(filepath);

                xlWorkBook.SaveAs(info);

                ExcelGeneratedWithError = false;

            }
            catch (Exception ex)
            {
                ExcelGeneratedWithError = true;
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Impossible d'exporter en Excel";
            }
            finally
            {
                try
                {
                    xlWorkBook.Close(0);
                    xlApp.Application.Quit();
                }
                catch(Exception ex)
                {

                }
                            

                //Kill processId Excel
                if (processId != 0)
                {
                    Process excelProcess = Process.GetProcessById((int)processId);
                    excelProcess.CloseMainWindow();
                    excelProcess.Refresh();
                    excelProcess.Kill();
                }

                //release COM object
                try
                {
                    if(xlWorkSheet != null)
                        System.Runtime.InteropServices.Marshal.ReleaseComObject(xlWorkSheet);
                    if (xlWorkBook != null)
                        System.Runtime.InteropServices.Marshal.ReleaseComObject(xlWorkBook);
                    if (xlApp != null)
                        System.Runtime.InteropServices.Marshal.ReleaseComObject(xlApp);

                    xlWorkSheet = null;
                    xlWorkBook = null;
                    xlApp = null;
                }
                catch (Exception ex)
                {
                    xlWorkSheet = null;
                    xlWorkBook = null;
                    xlApp = null;
                    lbl_erreur.Visible = true;
                    lbl_erreur.InnerText = ("Exception Occured while releasing object " + ex.ToString());
                }
                finally
                {
                    GC.Collect();
                }
            }


            if (!ExcelGeneratedWithError)
                DownloadFile(filepath, filename);
        }

        /// <summary>
        /// Download file with filepath
        /// </summary>
        /// <param name="filepath"></param>
        private void DownloadFile(string filepath, string filename)
        {
            try
            {
                Response.ContentType = "Application/xlsx";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename);
                Response.TransmitFile(filepath);
                Response.End();
            }
            catch (Exception ex)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Impossible de télécharger le fichier Excel : " + ex.Message;
            }
        }

        protected void btn_excel_csv_Click(object sender, EventArgs e)
        {
            string filename = "RapportProjet.csv";
            string directory = Server.MapPath("Excel/");
            string filepath = directory + filename;

            if(File.Exists(filepath))
            {
                File.Delete(filepath);
            }

            var file = File.CreateText(filepath);
            file.Close();

            RapportNode rapportNode = (RapportNode)Session["rapportNode"];

            string fileContent = "Nom Projet;Nom Catégorie;Nom Employé;Total d'heure;Date;Note;Nombre d'Heures";
            fileContent += "\n";

            //Projet
            for (int x = 0; x < rapportNode.Child.Count; x++)
            {
                var projet = rapportNode.Child[x];

                fileContent += "Total de : " + projet.Nom + "; ; ;";
                fileContent += formatHeureFloat(projet.NbHeure);
                fileContent += "\n";

                //Sous-Catégorie
                for (int y = 0; y < projet.Child.Count; y++)
                {
                    var s_cat = projet.Child[y];
                    fileContent += "Total de : " + s_cat.Nom + "; ; ;";
                    fileContent += formatHeureFloat(s_cat.NbHeure);
                    fileContent += "\n";

                    //Employé
                    for (int z = 0; z < s_cat.Child.Count; z++)
                    {
                        var emp = s_cat.Child[z];

                        fileContent += projet.Nom + ";";
                        fileContent += s_cat.Nom + ";";
                        fileContent += emp.Nom + ";";
                        fileContent += formatHeureFloat(emp.NbHeure);
                        fileContent += "\n";

                        for (int a = 0; a < emp.Child.Count; a++)
                        {
                            var ft = emp.Child[a];

                            fileContent += projet.Nom + ";";
                            fileContent += s_cat.Nom + ";";
                            fileContent += emp.Nom + ";";
                            fileContent += formatHeureFloat(emp.NbHeure) + ";";
                            fileContent += ft.Nom + ";";
                            fileContent += ft.Description + ";";
                            fileContent += ft.NbHeure;
                            fileContent += "\n";

                            if (fileContent.Length >= 400000)
                            {
                                SaveAppendText(directory, filepath, fileContent);
                                fileContent = "";
                            }
                        }
                    }
                }
            }

            if (fileContent.Length != 0)
            {
                SaveAppendText(directory, filepath, fileContent);
            }

            DownloadFile(filepath, filename);
        }


        //Write filecontent append to the filetext
        private void SaveAppendText(string directory, string filename, string fileContent)
        {

            if (!Directory.Exists(directory))
                Directory.CreateDirectory(directory);

            File.AppendAllText(filename, fileContent, System.Text.Encoding.UTF8);

            //File.WriteAllText(filename, fileContent, System.Text.Encoding.UTF8);

        }
    }
}