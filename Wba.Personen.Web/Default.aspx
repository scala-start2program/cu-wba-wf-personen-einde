<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Wba.Personen.Web.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Personen</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
    <style>
        .popup {
            display: block;
            position: fixed;
            top: 80px;
            left: 50%;
            width: 60%;
            height: auto;
            margin-left: -30%;
        }
        .inactive
        {
            opacity:0.2;
        }
        .active
        {
            opacity:1;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hidID" runat="server" />
        <div class="jumbotron">
            <h1>Beheer personen</h1>
        </div>
        <asp:Panel ID="panMain" runat="server">
            <div class="container">
                <div class="row">
                    <asp:LinkButton ID="lnkAddPerson" runat="server" CssClass="btn btn-primary" OnClick="lnkAddPerson_Click">Nieuwe persoon</asp:LinkButton>
                </div>
                <div class="row">
                    <asp:GridView ID="grdPersonen" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblNaam" runat="server" Text='<%# Eval("naam") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Naam
                                </HeaderTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblVoornaam" runat="server" Text='<%# Eval("voornaam") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Voornaam
                                </HeaderTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblGeboortedatum" runat="server" Text='<%# FormatDate(Eval("geboortedatum")) %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Geboortedatum
                                </HeaderTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblLeeftijd" runat="server" Text='<%# Eval("Leeftijd") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Geslacht
                                </HeaderTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblGeslacht" runat="server" Text='<%# BepaalGeslacht(Eval("IsMan")) %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    Geslacht
                                </HeaderTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditPersoon" runat="server"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CssClass="btn btn-sm btn-warning"
                                        ToolTip="Wijzig deze persoon"
                                        OnClick="lnkEditPersoon_Click">
                                        <i class="fas fa-pencil-alt"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDeletePersoon" runat="server"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CssClass="btn btn-sm btn-danger"
                                        ToolTip="Verwijder deze persoon"
                                        OnClick="lnkDeletePersoon_Click"
                                        OnClientClick="return confirm('Ben je zeker dat deze persoon mag verwijderd worden?');">
                                        <i class="fas fa-trash"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle CssClass="bg-dark text-light" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="panNewEdit" runat="server" CssClass="popup">
            <div class="card ">
                <div class="card-header bg-dark text-light">
                    <h2>
                        <asp:Label ID="lblHeader" runat="server" Text="Persoon toevoegen"></asp:Label></h2>
                </div>
                <div class="card-body">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" style="width: 150px;">Naam : </span>
                        </div>
                        <asp:TextBox ID="txtNaam" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" style="width: 150px;">Voornaam : </span>
                        </div>
                        <asp:TextBox ID="txtVoornaam" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" style="width: 150px;">Geboortedatum : </span>
                        </div>
                        <asp:TextBox ID="txtGeboortedatum" type="date" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text" style="width: 150px;">Geslacht : </span>
                        </div>
                        <span class="form-control">
                            <table>
                                <tr>
                                    <td style="padding-right: 5px;">
                                        <asp:RadioButton ID="rdbMan" runat="server"
                                            GroupName="gender" CssClass="form-check"
                                            Checked="true" Text="&nbsp;Man" /></td>
                                    <td>
                                        <asp:RadioButton ID="rdbVrouw" runat="server"
                                            GroupName="gender" CssClass="form-check"
                                            Text="&nbsp;Vrouw" /></td>
                                </tr>
                            </table>


                        </span>
                    </div>
                </div>
                <div class="card-footer bg-light">
                    <div class="btn-group">
                        <asp:LinkButton ID="lnkSave" runat="server"
                            CssClass="btn btn-success" OnClick="lnkSave_Click">
                            <i class="far fa-save" ></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="lnkCancel" runat="server"
                            CssClass="btn btn-danger" OnClick="lnkCancel_Click"                            >
                            <i class="fas fa-undo"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>


    </form>
</body>
</html>
