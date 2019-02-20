using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UrbanEco.RapportDepenses;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.IO;

namespace UrbanEco
{
    public partial class RapportDepensePage : System.Web.UI.Page
    {
        [DllImport("user32.dll", SetLastError = true)]
        static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);

            RapportDepenseNode rapportNode = (RapportDepenseNode)Session["rapportNode"];
            tbx_dateDebut.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateDebut"]);
            tbx_dateFin.InnerHtml = Layout.GetDateFormated((DateTime)Session["dateFin"]);

            if (rapportNode != null)
            {
                rapportRepeater.DataSource = rapportNode.Childs;
                rapportRepeater.DataBind();
            }

            bool isExcelInstalled = Type.GetTypeFromProgID("Excel.Application") != null ? true : false;
            btn_excel.Visible = isExcelInstalled;
        }

        protected string FormatMontant(object p_montant)
        {
            float montant = (float)p_montant;
            return montant.ToString("c2");
        }

        protected string FormatDate(object p_date)
        {
            DateTime date = (DateTime)p_date;
            return date.ToString("dd-MM-yyyy");
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            RapportDepenseNode rapportNode = (RapportDepenseNode)Session["rapportNode"];

            object misValue = System.Reflection.Missing.Value;


            //Excel
            Excel.Application xlApp = null;
            Excel.Workbook xlWorkBook = null;
            Excel.Worksheet xlWorkSheet = null;

            //File info
            string filename = "RapportDepense.xlsx";
            string directory = Server.MapPath("Excel/");
            string filepath = directory + filename;

            if (!Directory.Exists(directory))
                Directory.CreateDirectory(directory);

            bool ExcelGeneratedWithError = false;

            bool isExcelInstalled = Type.GetTypeFromProgID("Excel.Application") != null ? true : false;

            if (!isExcelInstalled)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Le serveur ne possède pas Excel.\nL'exportation en XLSX est donc impossible.";
                return;
            }

            uint processId = 0;

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
                for (int x = 0; x < rapportNode.Childs.Count; x++)
                {
                    var categorie = rapportNode.Childs[x];
                    //xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;

                    xlWorkSheet.Cells[indexX, 1].Value = categorie.Nom;
                    xlWorkSheet.Cells[indexX, 4].Value = FormatMontant(categorie.TotalDepense);
                    indexX++;
                    indexX++;

                    //Sous-Catégorie
                    for (int y = 0; y < categorie.Childs.Count; y++)
                    {
                        var employe = categorie.Childs[y];

                        xlWorkSheet.Cells[indexX, 1].Value = categorie.Nom;
                        xlWorkSheet.Cells[indexX, 2].Value = employe.Nom;
                        xlWorkSheet.Cells[indexX, 3].Value = employe.Date;
                        xlWorkSheet.Cells[indexX, 4].Value = FormatMontant(employe.TotalDepense);

                        indexX++;
                    }

                    indexX++;
                    indexX++;
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
                lbl_erreur.InnerText = "Impossible d'exporter en Excel : " + ex.Message;
            }
            finally
            {
                xlWorkBook.Close(0);
                xlApp.Application.Quit();

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
                    System.Runtime.InteropServices.Marshal.ReleaseComObject(xlWorkSheet);
                    System.Runtime.InteropServices.Marshal.ReleaseComObject(xlWorkBook);
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

            //File info
            string filename = "RapportDepense.csv";
            string directory = Server.MapPath("Excel/");
            string filepath = directory + filename;

            RapportDepenseNode rapportNode = (RapportDepenseNode)Session["rapportNode"];

            string fileContent = "Type de dépense;Nom employé;Date;Montant";
            fileContent += "\n";

            //Projet
            for (int x = 0; x < rapportNode.Childs.Count; x++)
            {
                var categorie = rapportNode.Childs[x];
                //xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;

                fileContent += "Total de : " + categorie.Nom + "; ; ;";
                fileContent += FormatMontant(categorie.TotalDepense);
                fileContent += "\n";

                //Sous-Catégorie
                for (int y = 0; y < categorie.Childs.Count; y++)
                {
                    var employe = categorie.Childs[y];

                    fileContent += categorie.Nom + ";";
                    fileContent += employe.Nom + ";";
                    fileContent += employe.Date + ";";
                    fileContent += FormatMontant(employe.TotalDepense);

                    fileContent += "\n";
                }

            }

            if (fileContent.Length != 0)
            {
                if (!Directory.Exists(directory))
                    Directory.CreateDirectory(directory);


                File.WriteAllText(filepath, fileContent, System.Text.Encoding.UTF8);
            }

            DownloadFile(filepath, filename);
        }
    }
}