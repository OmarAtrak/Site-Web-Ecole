<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentProfesseur.aspx.cs" Inherits="Ecoule.PageContentProfesseur" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style9 {
            width: 54%;
            margin-left: 30px;
        }
        .msg {
            color:red;
            font-weight:500;
        }
        .auto-style10 {
            text-align:left;
            width: 10%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <div>
        <asp:ScriptManager ID="sm" runat="server">
            <Scripts></Scripts>
        </asp:ScriptManager>
        <br />
        <span id="prof"></span>
        <h3>Professeur</h3>
        <div>
            <asp:UpdatePanel ID="up" runat="server">
                <ContentTemplate>
            <table id="tblEtd" runat="server" class="auto-style9">
                <tr>
                    <td class="auto-style1">Nom</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtNomProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Prenom</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtPrenomProf" runat="server" Width="186px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Module</td>
                    <td class="auto-style10">
                        <asp:DropDownList ID="cmbModule" runat="server" Width="186px" DataSourceID="ModuleData" DataTextField="LIBELLE" DataValueField="LIBELLE"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Date de Naissance</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtDateProf" TextMode="Date" runat="server" Width="186px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Telephone</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtTeleProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Mot de Passe</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtMotPasseProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Adresse</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtAdresseProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Salire</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtSalaireProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Gmail</td>
                    <td class="auto-style10">
                        <asp:TextBox ID="txtGmailProf" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">Sexe</td>
                    <td class="auto-style10">
                        <asp:RadioButtonList ID="sexeProf" runat="server" CssClass="auto-style3" RepeatDirection="Horizontal">
                            <asp:ListItem>M</asp:ListItem>
                            <asp:ListItem>F</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td  colspan="2" class="td_vide"><asp:Label ID="lblmssgProf" runat="server" Text=""></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2" class="auto-style1">
                        <asp:Button ID="btnAjoutProf" CssClass="btnsOperation btnAjout" runat="server" Text="Ajout" OnClick="btnAjoutProf_Click" Width="100px" />
                        <asp:Button ID="btnModiferProf" CssClass="btnsOperation btnModifier" runat="server" Text="Modifer" Width="100px" OnClick="btnModiferProf_Click" />
                        <asp:Button ID="btnSupprimerProf" CssClass="btnsOperation btnSupprimer" runat="server" Text="Suprimer" Width="100px" OnClick="btnSupprimerProf_Click" OnClientClick="return ConfirmDelete(this);"/>
                        <asp:Button ID="btnInitialiser" CssClass="btnsOperation btnInsialiser" runat="server" Text="Initialiser" Width="100px" OnClick="btnInitialiser_Click"/>
                    </td>
                </tr>
            </table>
                    <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [LIBELLE] FROM [MODULE]"></asp:SqlDataSource>
            <br />
            <asp:TextBox ID="txtRechercheProf" CssClass="txtRecherche" runat="server"></asp:TextBox>
            <asp:ImageButton ID="btnRecherche" runat="server" CssClass="btnRecherche" ImageUrl="~/icons/recherche.png" Width="25" OnClick="btnRecherche_Click" />
            <label id="lblmsg" runat="server" class="msg" visible="false">il n'y pas un Professeur en cette Nom ou Prenom</label>
            <asp:GridView ID="ListProf" runat="server" Width="80%" CssClass="list" BorderColor="#CCCCCC" BorderStyle="None" 
                BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False"
                OnSelectedIndexChanged="ListProf_SelectedIndexChanged" AllowSorting="True" BackColor="White" OnSorting="ListProf_Sorting">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
                    <asp:BoundField DataField="MATRICULE" HeaderText="Numero" ReadOnly="True" SortExpression="MATRICULE" />
                    <asp:BoundField DataField="NOM" HeaderText="Nom" SortExpression="NOM" />
                    <asp:BoundField DataField="PRENOM" HeaderText="Prenom" SortExpression="PRENOM" />
                    <asp:BoundField DataField="LIBELLE" HeaderText="Module" SortExpression="LIBELLE" />
                    <asp:BoundField DataField="TELEPHONE" HeaderText="Telephone" SortExpression="TELEPHONE" />
                    <asp:BoundField DataField="Date" HeaderText="Date Naissance" SortExpression="Date" ReadOnly="True" />
                    <asp:BoundField DataField="EMAIL" HeaderText="Email" SortExpression="EMAIL" ReadOnly="True" />
                    <asp:BoundField DataField="MOT_PASSE_PROF" HeaderText="Mot Passe" SortExpression="MOT_PASSE_PROF" />
                    <asp:BoundField DataField="SEXE" HeaderText="Sexe" SortExpression="SEXE" />
                    <asp:BoundField DataField="ADRESSE" HeaderText="Adresse" SortExpression="ADRESSE" />
                    <asp:BoundField DataField="SALAIRE" HeaderText="Salaire" SortExpression="SALAIRE" />
                    <asp:BoundField DataField="GMAIL" HeaderText="Gmail" SortExpression="GMAIL" />
                </Columns>
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="true" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066"/>
                <SelectedRowStyle BackColor="#669999" Font-Bold="true" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>
            </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <span id="finProf" runat="server"></span>
        </div>
    </div>
</asp:Content>
