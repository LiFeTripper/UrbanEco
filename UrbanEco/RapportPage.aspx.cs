using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using UrbanEco.Rapports;
using Excel = Microsoft.Office.Interop.Excel;
using System.Net;

namespace UrbanEco
{
    public partial class RapportPage : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Autorisation2.Autorisation(false, false);
            chercherRapport();
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

            Console.WriteLine(nbHeure);

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
            string filePath = Server.MapPath("Excel/" + filename);

            try
            {
                //Open Excel
                xlApp = new Excel.Application();
                xlWorkBook = xlApp.Workbooks.Add(misValue);
                xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

                xlApp.Visible = false;

                int indexX = 1;

                //Projet
                for (int x = 0; x < rapportNode.Child.Count; x++)
                {
                    var projet = rapportNode.Child[x];
                    //xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                    indexX++;


                    //Sous-Catégorie
                    for (int y = 0; y < projet.Child.Count; y++)
                    {
                        var s_cat = projet.Child[y];
                        //xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                        //xlWorkSheet.Cells[indexX, 2].Value = s_cat.Nom;
                        indexX++;


                        //Employé
                        for (int z = 0; z < s_cat.Child.Count; z++)
                        {
                            var emp = s_cat.Child[z];

                            xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                            xlWorkSheet.Cells[indexX, 2].Value = s_cat.Nom;
                            xlWorkSheet.Cells[indexX, 3].Value = emp.Nom;
                            xlWorkSheet.Cells[indexX, 4].Value = formatHeureFloat(emp.NbHeure);
                            indexX++;
                        }
                    }
                }

                //Delete existing file
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }

                //Save file
                FileInfo info = new FileInfo(filePath);
                
                xlWorkBook.SaveAs(info);
            }
            catch(Exception ex)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Impossible d'exporter en Excel : " + ex.Message;
            }

            xlWorkBook.Close(0);
            xlApp.Quit();

            releaseComObject(xlWorkSheet);
            releaseComObject(xlWorkBook);
            releaseComObject(xlApp);

            DownloadFile(filePath);

        }

        private void DownloadFile(string filepath)
        {
            try
            {
                Response.ContentType = "Application/xlsx";
                Response.AppendHeader("Content-Disposition", "attachment; filename=RapportProjet.xlsx");
                Response.TransmitFile(filepath);
                Response.End();

                lbl_success.Visible = true;
                lbl_success.InnerText = "Exportation Excel réussie !";
            }
            catch (Exception ex)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Impossible d'exporter en Excel : " + ex.Message;
            }
        }

        private void releaseComObject(object obj)
        {
            try
            {
                System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
                obj = null;
            }
            catch (Exception ex)
            {
                obj = null;
                //MessageBox.Show("Exception Occured while releasing object " + ex.ToString());
            }
            finally
            {
                GC.Collect();
            }
        }
    }
}