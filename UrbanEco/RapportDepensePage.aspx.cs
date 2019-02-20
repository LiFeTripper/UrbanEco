﻿using System;
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
        }

        protected string FormatMontant(object p_montant)
        {
            float montant = (float)p_montant;
            return montant.ToString("c2");
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

                if (!ExcelGeneratedWithError)
                    DownloadFile(filepath);
            }
        }

        /// <summary>
        /// Download file with filepath
        /// </summary>
        /// <param name="filepath"></param>
        private void DownloadFile(string filepath)
        {
            try
            {
                Response.ContentType = "Application/xlsx";
                Response.AppendHeader("Content-Disposition", "attachment; filename=RapportDepense.xlsx");
                Response.TransmitFile(filepath);
                Response.End();
            }
            catch (Exception ex)
            {
                lbl_erreur.Visible = true;
                lbl_erreur.InnerText = "Impossible de télécharger le fichier Excel : " + ex.Message;
            }
        }
    }
}