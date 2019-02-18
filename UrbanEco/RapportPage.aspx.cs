using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UrbanEco.Rapports;
using Excel = Microsoft.Office.Interop.Excel;

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

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            RapportNode rapportNode = (RapportNode)Session["rapportNode"];

            object misValue = System.Reflection.Missing.Value;

            Excel.Application xlApp = new Excel.Application();
            Excel.Workbook xlWorkBook = xlApp.Workbooks.Add(misValue);
            Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Worksheets.get_Item(1);

            int indexX = 1;

            for (int x = 0; x < rapportNode.Child.Count; x++)
            {
                var projet = rapportNode.Child[x];
                xlWorkSheet.Cells[indexX, 1].Value = projet.Nom;
                indexX++;

                for (int y = 0; y < projet.Child.Count; y++)
                {
                    var s_cat = projet.Child[y];
                    xlWorkSheet.Cells[indexX, 2].Value = s_cat.Nom;
                    indexX++;

                    for (int z = 0; z < s_cat.Child.Count; z++)
                    {
                        var emp = s_cat.Child[z];

                        xlWorkSheet.Cells[indexX, 3].Value = emp.Nom + " - " + emp.NbHeure + "h";
                        indexX++;
                    }
                }
            }

            xlApp.Visible = true;


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