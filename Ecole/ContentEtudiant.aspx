<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentEtudiant.aspx.cs" Inherits="Ecoule.PageContentEtudiant" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style9 {
            width: 5%;
        }
        .auto-style4 {
            margin-left:20px;
        }
        .auto-style10 {
            width: 70%;
            margin-left: 35px;
        }
        .msg {
            color:red;
            font-weight:500;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <div>
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <br />
        <span id="etd"></span>
        <h3>Etudiant</h3>
                <div>
            <table class="auto-style10" id="tblEtudiant" runat="server">
                <tr>
                    <td class="auto-style9">Nom</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtNomEtd" runat="server" MaxLength="20"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Prenom</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtPrenomEtd" runat="server" MaxLength="20"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Group</td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="txtGroupEtd" runat="server" Width="186px" DataSourceID="GroupEtdData" DataTextField="ID_GROUP" DataValueField="ID_GROUP"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Date de Naissance</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtDateEtd" runat="server" TextMode="Date" Width="186px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Telephone</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtTeleEtd" runat="server" TextMode="Phone" MaxLength="10"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Mot de Passe</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtMotPasseEtd" runat="server" MaxLength="10"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Adresse</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtAdresseEtd" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Sexe</td>
                    <td class="auto-style2">
                        <asp:RadioButtonList ID="sexeEtd" runat="server" CssClass="auto-style3" RepeatDirection="Horizontal">
                            <asp:ListItem>M</asp:ListItem>
                            <asp:ListItem>F</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="auto-style1">
                        <asp:Button ID="btnAjout" CssClass="btnsOperation btnAjout" runat="server" Text="Ajout" OnClick="btnAjoutEtd_Click" Width="100px" />
                        <asp:Button ID="btnModifier" CssClass="btnsOperation btnModifier" runat="server" Text="Modifer" Width="100px" OnClick="btnModifier_Click" />
                        <asp:Button ID="btnSupprimer" CssClass="btnsOperation btnSupprimer" runat="server" Text="Suprimer" Width="100px" OnClick="btnSupprimer_Click" OnClientClick="return ConfirmDelete(this);"/>
                        <asp:Button ID="btnInsialiser" CssClass="btnsOperation btnInsialiser" runat="server" Text="initialiser" Width="100px" OnClick="btnInsialiser_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="auto-style9"><asp:Label id="lblmsg" runat="server" Text=""></asp:Label></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="GroupEtdData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT convert(varchar,NUMERO_SECTION)+'AC'+convert(varchar,NUMERO_GROUP)  as ID_GROUP FROM [GROUP]"></asp:SqlDataSource>
            <br />
            <asp:TextBox ID="txtRecherchEtd" CssClass="txtRecherche" OnTextChanged="txtRecherchEtd_TextChanged" runat="server"></asp:TextBox>
            <asp:ImageButton ID="btnRechercheEtd1" runat="server" CssClass="btnRecherche" ImageUrl="~/icons/recherche.png" Width="25" OnClick="btnRechercheEtd1_Click" />
            <label id="lblmsgrecherche" class="msg" runat="server" visible="false">il n'y pas un Etudiant en cette Nom ou Prenom</label>
                
            <asp:GridView id="ListEtudiant" runat="server" OnSelectedIndexChanged="ListEtudiant_SelectedIndexChanged"
                Width="90%" CssClass="list"
                AutoGenerateColumns="False"
                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                AllowSorting="True" BackColor="White" OnSorting="ListEtudiant_Sorting">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
                    <asp:BoundField DataField="NUMERO_ETUDIANT" HeaderText="Numero" InsertVisible="False" ReadOnly="True" SortExpression="NUMERO_ETUDIANT" />
                    <asp:BoundField DataField="groupEtd" HeaderText="Group" SortExpression="groupEtd" />
                    <asp:BoundField DataField="NOM" HeaderText="Nom" SortExpression="NOM" />
                    <asp:BoundField DataField="PRENOM" HeaderText="Prenom" SortExpression="PRENOM" />
                    <asp:BoundField DataField="TELEPHONE" HeaderText="Telephone" SortExpression="TELEPHONE" />
                    <asp:BoundField DataField="Date" HeaderText="Date Naissance" SortExpression="Date" />
                    <asp:BoundField DataField="EMAIL" HeaderText="Email" ReadOnly="True" SortExpression="EMAIL" />
                    <asp:BoundField DataField="MOT_PASSE_ETUDIANT" HeaderText="Mot Passe" SortExpression="MOT_PASSE_ETUDIANT" />
                    <asp:BoundField DataField="ADRESSE" HeaderText="Adresse" SortExpression="ADRESSE" />
                    <asp:BoundField DataField="SEXE" HeaderText="Sexe" SortExpression="SEXE" />
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
            <br />
            <span id="finEtd" runat="server"></span>
        </div>
    </div>
    <script>

        //let test_num = /^[0][6-7][0-9]{8}$/;
        //if (txtTeleEtd.match(test_num)) {

        //} else {
        //    alert("Numero de Telephone Incorrect")
        //    return false;
        //}
    </script>
</asp:Content>
