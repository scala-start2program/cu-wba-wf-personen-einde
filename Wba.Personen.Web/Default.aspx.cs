using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Wba.Personen.Lib.Entities;
using Wba.Personen.Lib.Services;

namespace Wba.Personen.Web
{
    public partial class Default : System.Web.UI.Page
    {
        PersoonService persoonService;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                persoonService = new PersoonService();
                ViewState["ps"] = persoonService;
                BuildGrid();
                panNewEdit.Visible = false;
            }
            else
            {
                if (persoonService == null)
                {
                    persoonService = (PersoonService) ViewState["ps"];
                }
            }
        }
        private void BuildGrid()
        {
            grdPersonen.DataSource = persoonService.Personen;
            grdPersonen.DataBind();
        }
        protected string FormatDate(object waarde)
        {
            DateTime datum = (DateTime)waarde;
            return datum.ToString("dd/MM/yyyy");
        }
        protected string BepaalGeslacht(object waarde)
        {
            bool isMan = (bool)waarde;
            if (isMan)
                return "Man";
            else
                return "Vrouw";
        }

        protected void lnkAddPerson_Click(object sender, EventArgs e)
        {
            panMain.CssClass = "inactive";
            panMain.Enabled = false;
            panNewEdit.Visible = true;

            txtNaam.Text = "";
            txtVoornaam.Text = "";
            txtGeboortedatum.Text = "";
            rdbMan.Checked = false;
            rdbVrouw.Checked = false;

            lblHeader.Text = "Een nieuwe persoon toevoegen";
            hidID.Value = "";

            txtNaam.Focus();
        }
        protected void lnkEditPersoon_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            hidID.Value = lnk.CommandArgument;
            Persoon persoon = persoonService.GetPersoon(lnk.CommandArgument);
            if(persoon != null)
            {
                rdbMan.Checked = false;
                rdbVrouw.Checked = false;
                txtNaam.Text = persoon.Naam;
                txtVoornaam.Text = persoon.Voornaam;
                txtGeboortedatum.Text = persoon.Geboortedatum.ToString("yyyy-MM-dd");
                if (persoon.IsMan)
                    rdbMan.Checked = true;
                else
                    rdbVrouw.Checked = true;

                panMain.CssClass = "inactive";
                panMain.Enabled = false;
                panNewEdit.Visible = true;

                lblHeader.Text = "Een persoon wijzigen";
                txtNaam.Focus();
            }
        }

        protected void lnkDeletePersoon_Click(object sender, EventArgs e)
        {
            // we zoeken de persoon die we willen wissen
            LinkButton lnk = (LinkButton)sender;
            hidID.Value = lnk.CommandArgument;
            Persoon persoon = persoonService.GetPersoon(lnk.CommandArgument);
            // we verwijderen de persoon uit de List
            persoonService.VerwijderPersoon(persoon);
            // we vullen de GridView terug met de nieuwe situatie 
            BuildGrid();
            // we werken de ViewState bij 
            ViewState["ps"] = persoonService;
        }



        protected void lnkSave_Click(object sender, EventArgs e)
        {
            Persoon persoon;
            if(hidID.Value == "")
            {
                // is hidID.Value == "" dan gaat het om een nieuwe persoon
                persoon = new Persoon();
            }
            else
            {
                // anders is het een bestaande persoon die we moeten opzoeken
                persoon = persoonService.GetPersoon(hidID.Value);
            }
            persoon.Naam = txtNaam.Text;
            persoon.Voornaam = txtVoornaam.Text;
            persoon.Geboortedatum = DateTime.Parse(txtGeboortedatum.Text);
            if (rdbMan.Checked)
                persoon.IsMan = true;
            else
                persoon.IsMan = false;
            if(hidID.Value == "")
            {
                // is het een nieuwe persoon dan moeten we die nog toevoegen aan de List
                persoonService.VoegPersoonToe(persoon);
            }
            // we vullen de GridView terug met de nieuwe situatie 
            BuildGrid();
            // we werken de ViewState bij 
            ViewState["ps"] = persoonService;
            // we zetten visueel weer alles in orde
            panNewEdit.Visible = false;
            panMain.CssClass = "active";
            panMain.Enabled = true;
        }

        protected void lnkCancel_Click(object sender, EventArgs e)
        {
            panNewEdit.Visible = false;
            panMain.CssClass = "active";
            panMain.Enabled = true;
        }
    }
}