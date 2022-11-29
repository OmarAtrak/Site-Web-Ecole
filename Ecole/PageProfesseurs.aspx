<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageProfesseurs.aspx.cs" Inherits="Ecoule.PageProfesseurs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Professeur</title>
    <link rel="stylesheet" href="bootstrap.min.css" />
    <!--<link rel="stylesheet" href="Style/StylePageProf.css" />-->
    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:400,500,300,700);

        * {
            margin: 0px;
            padding: 0px;
            box-sizing:border-box;
        }

        body {
            /*background: linear-gradient(to right, #7ce0ea, #71c6ce);*/
            font-family: 'Roboto', sans-serif;
            background-color: #e2e5a7;
        }

        /*menu pranciapale*/
        nav {
            height: 70px;
            width: 100%;
            position: fixed;
            top: 0;
            background-color: #0a1e70;
            color: white;
        }

        nav > ul {
            float: right;
            height: 100%;
            width: 79%;
            text-align: right;
        }

        nav > ul > li {
            display: inline-block;
            margin-top: 20px;
            margin-right: 50px;
            font-size: 20px;
            font-weight: 700;
        }

        a {
            text-decoration: none;
            color: white;
        }

        nav > ul > li > a {
            float: right;
            transition: all 0.4s ease-in-out;
        }

        nav > ul > li > a:hover {
            color: coral;
            text-decoration: none;
        }

        a:hover {
            text-decoration: none;
            color: white;
        }

        table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }

        .tbl-header {
            background-color: rgba(255,255,255,0.3);
        }

        .tbl-content {
            height: 300px;
            border: 1px solid rgba(255,255,255,0.3);
            overflow-x: auto;
        }

        th {
            padding: 20px 5px;
            text-align: center;
            font-weight: 400;
            font-size: 24px;
            text-transform: uppercase;
        }

        td {
            padding: 10px;
            text-align: center;
            font-weight: 400;
            font-size: 20px;
            border-bottom: .4px solid rgba(0,0,0,.4);
            word-break: break-word;
        }

        .profil {
            float: left;
            margin-top: 5px;
            margin-left: 20px;
            /*transform: rotate(90deg);*/
            text-decoration: none;
            color: white;
            font-size: 32px;
        }

        .profil:hover {
            text-decoration: none;
            color: #fff;
        }

        .align {
            text-align: center;
            display: inline-block;
            width: 85%;
            height: 100%;
        }

        .right {
            text-align: right;
        }

        .left {
            text-align: left;
        }

        .list {
            width: 100%;
            margin: auto;
            border: .4px solid rgba(0,0,0,0.4);
        }

        .sidebar {
            position: fixed;
            top: 0px;
            left: -350px;
            height: 100%;
            width: 350px;
            background: #130948;
            transition: all 0.3s ease-in;
        }

        ul {
            list-style-type: none;
        }

        .sidebar > ul {
            margin-top: 50px;
            width: 100%;
        }

        .sidebar > ul > li {
            text-align: center;
            border-bottom: solid rgba(255,255,255,0.1);
            width: 100%;
            height: 50px;
            line-height: 50px;
            transition: all 0.5s ease;
            border-left: 3px solid #130948;
        }

        .sidebar > ul > li > a {
            display: block;
            height: 100%;
            width: 100%;
         }

        .menu a {
            cursor: pointer;
        }

        .sidebar > ul > li:hover {
            background-color: rgba(23, 95, 215, 0.3);
            border-left: 3px solid #00b7c3;
        }

        .sidebar span #exit {
            font-size: 20px;
            font-weight: 500;
            margin: 10px;
        }

        .exit-menu {
            float: right;
        }

        .lblemail {
            border-radius: 65px;
            margin: auto;
            margin-top: 30px;
            border: solid #00b7c3 2px;
            border-left: none;
            width: 85%;
        }

        .lblemail img {
            margin-right: 10px;
        }

        .icon {
            float: left;
            margin-top: 10px;
            margin-left: 10px;
        }

        .btn_sidebar {
            width: 100%;
            height: 100%;
            background-color: initial;
            color: #fff;
            border: none;
            padding-left: 50px;
            transform: translateY(-40px);
            transition: all 0.3s ease-out;
        }

        .bg_sidebar {
            position: absolute;
            top: -100%;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            opacity: 0;
            transition: opacity .7s;
            transition-delay: .2s;
        }

        .content_profil, .content_mot_passe {
            position: absolute;
            top: -100%;
            left: 7.5%;
            width: 85%;
            height: 400px;
            background-color: white;
            border-radius: 15px;
            box-sizing: border-box;
            padding: 10px;
            transition: all .5s;
            opacity: 0;
        }

        *:focus {
            outline: none;
        }

        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            border-radius: 5px;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.25);
        }

        ::-webkit-scrollbar-thumb {
            border-radius: 5px;
            background-color: #00b7c3;
        }

        .btns_sidebar{
            width: 100%;
            height: 100%;
            background-color: initial;
            color: #fff;
            border: none;
            padding-left: 50px;
            transform: translateY(-40px);
            transition: all 0.3s ease-out;
        }

        .btn_updatePassword {
            border: none;
            border-radius: 5px;
            width: 200px;
            height: 50px;
            background-color: #b7b7b5
        }

        h3 {
            margin-top:100px;
            margin-left:20px;
        }

        .content_Seance {
            width:100%;
            height:500px;
            padding:5px;
        }

        .BoxlistSeance {
            width:70%;
            height:400px;
            margin-left:10px;
            box-sizing:border-box;
            float:right;
            overflow-y:auto;
        }

        .content_Seance label {
            margin-left: 10px;
        }

        .content_Seance table {
            border-radius:10px;
            border:1px solid silver;
            float:left;
            width:27%;
            height:400px;
        }

        .content_Seance table tr td {
            border:none;
        }

        .tbl_ValideSeance tr td {
            padding-top: 0px;
            padding-bottom: 0px;
        }

        #ListSeance {
            width:100%;
        }

        #ListSeance th {
            font-size:18px;
            font-weight:500;
        }

        #btnValiderSeance {
            border-radius:5px;
            width:60%;
            height:40px;
            margin-top:20px;
            margin-bottom:20px;
        }
        .lbl_choix {
            margin-left:200px;
            margin-right:20px;
        }
        .cmb_choix {
            width:10%;
            margin-top:20px;
            margin-bottom:20px;
        }
        .list_view {
            margin-top:20px;
            margin-bottom:20px;
            margin-left:100px;
        }
        .lbl_choix {
            margin-left:200px;
            margin-right:20px;
        }
        .lbl_choix2 {
            margin-left:70px;
            margin-right:10px;
        }
        .cmb_choix {
            margin-top:20px;
            margin-bottom:20px;
        }
        .list_view {
            margin-top:20px;
            margin-bottom:20px;
            margin-left:100px;
        }
        #btnAjoutParticipant {
            margin-left:20%;
        }
        .btnPresedent {
            width:10%;
            margin-left:30%;
            margin-right:10px;
            margin-top:10px;
        }
        #btnValiderNote{
            width:10%;
            margin-left:30%;;
            margin-right:10px;
            margin-top:10px;
        }
        .btnSuivant {
            width:10%;
            margin-left:10px;
            margin-top:10px;
        }
        .lbl_choixP {
            margin-left:120px;
            margin-right:20px;
        }
        .btn_refreche {
            margin-left: 75.7%;
            margin-bottom: -75px;
        }
        .btn_pdf {
            margin-left: 75.5%;
            margin-bottom: -52px;
        }
        #deplacementEtdP {
            display:inline;
        }
        h5 {
            margin: 50px 7.5% 10px;
        }
        #lblNumeroExame,#lblIDModule,#lblDate {
            margin-left:10%;
        }
        #btnAjouterExame {
            margin-left:15%;
        }
        .auto-style1 {
            margin-bottom: 1px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
            <Scripts>
                <asp:ScriptReference Path="~/JS/test.js" />
            </Scripts>
        </asp:ScriptManager>
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
        <nav>
            <ul>
                <li><a href="#Seance">Seance</a></li>
                <li><a href="#Participer">Presence de Seance</a></li>
                <li><a href="#exame">Exame</a></li>
            </ul>
            <div id="bg_sidebar" runat="server" class="bg_sidebar"></div>
            <div class="menu">
                <a id="menu-btn" class="profil"><img src="icons/icons8-menu-49.png" width="50px" /></a>
                <div id="content-menu" class="sidebar">
                    <span class="exit-menu"><a id="exit">X</a></span>
                    <div class="lblemail"><img src="icons/user.png" height="30px"/><asp:label ID="emailProf" runat="server"></asp:label></div>
                    <ul>
                        <li id="info"><a><img src="icons/login.png" class="icon" height="30px"/>Profil</a></li>
                        <li id="mot_passe"><img src="icons/lock.png" class="icon" height="30px"/><asp:Button ID="btn_ChangerMotPasse" runat="server" Text="Changer Mot de Passe" CssClass="btns_sidebar" OnClick="btn_ChangerMotPasse_Click"/></li>
                        <li><img class="icon" src="icons/logout.png" height="30px"/><asp:Button id="btn_exit" runat="server" Text="Déconnecter" CssClass="btns_sidebar" OnClick="btn_exit_Click"/></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div id="content_profil" class="content_profil">
            <table>
                <tr>
                    <th colspan="4">les information</th>
                </tr>
                <tr>
                    <td class="right">Numero:</td>
                    <td class="left"><asp:label ID="lblNumero" runat="server"></asp:label></td>
                    <td class="right">Email:</td>
                    <td class="left"><asp:label ID="lblEmail" runat="server"></asp:label></td>
                </tr>
                <tr>
                    <td class="right">Nom:</td>
                    <td class="left"><asp:label ID="lblNom" runat="server"></asp:label></td>
                    <td class="right">Prenom:</td>
                    <td class="left"><asp:label ID="lblPrenom" runat="server"></asp:label></td>
                </tr>
                <tr>
                    <td class="right">Date de Naissance:</td>
                    <td class="left"><asp:label ID="lblDateNaissance" runat="server"></asp:label></td>
                    <td class="right">Telephone:</td>
                    <td class="left"><asp:label ID="lblTele" runat="server"></asp:label></td>
                </tr>
            </table>
        </div>
        
        <div id="content">
            <div class="content_Seance">
                <br />
                <span id="Seance"></span>
                <h3>Seance</h3>
                <table class="tbl_ValideSeance">
                    <tr>
                        <th colspan="2">Ajouter Seance</th>
                    </tr>
                    <tr>
                        <td class="left"><label for="cmbGroup">Group</label></td>
                        <td class="left"><asp:DropDownList ID="cmbGroup" runat="server" AutoPostBack="True" Width="100%" DataSourceID="GroupData" DataTextField="ID_GROUP" DataValueField="ID_GROUP"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="left"><label for="cmbModule">Module</label></td>
                        <td class="left"><asp:DropDownList ID="cmbModule" runat="server" AutoPostBack="True" Width="100%" DataSourceID="ModuleData" DataTextField="LIBELLE" DataValueField="LIBELLE"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="left"><label for="Date">Date</label></td>
                        <td class="left"><asp:TextBox ID="txtDate" runat="server" AutoPostBack="true" TextMode="Date" Width="100%"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="left"><label for="cmbHeureDebut">Heure Debut</label></td>
                        <td class="left">
                            <asp:DropDownList ID="cmbHeureDebut" runat="server" AutoPostBack="true"  Width="100%">
                            <asp:ListItem>8:30</asp:ListItem>
                            <asp:ListItem>9:30</asp:ListItem>
                            <asp:ListItem>10:30</asp:ListItem>
                            <asp:ListItem>11:30</asp:ListItem>
                            <asp:ListItem>14:30</asp:ListItem>
                            <asp:ListItem>15:30</asp:ListItem>
                            <asp:ListItem>16:30</asp:ListItem>
                            <asp:ListItem>17:30</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="left"><label for="cmbHeureFin">Heure Fin</label></td>
                        <td class="left">
                            <asp:DropDownList ID="cmbHeureFin" runat="server" AutoPostBack="true" Width="100%">
                            <asp:ListItem>9:30</asp:ListItem>
                            <asp:ListItem>10:30</asp:ListItem>
                            <asp:ListItem>11:30</asp:ListItem>
                            <asp:ListItem>12:30</asp:ListItem>
                            <asp:ListItem>15:30</asp:ListItem>
                            <asp:ListItem>16:30</asp:ListItem>
                            <asp:ListItem>17:30</asp:ListItem>
                            <asp:ListItem>18:30</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="left"><label for="cmbSalle">Salle</label></td>
                        <td class="left"><asp:DropDownList ID="cmbSalle" runat="server" Width="100%" DataSourceID="SalleDisponibleData" ItemType="int" DataTextField="Salle" DataValueField="Salle"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="2"><asp:Button id="btnValiderSeance" runat="server" Text="Valider Seance" OnClick="btnValiderSeance_Click"/></td>
                    </tr>
                </table>
                <div class="BoxlistSeance">
                    <asp:GridView ID="ListSeance" runat="server" AutoGenerateSelectButton="True" OnSelectedIndexChanged="ListSeance_SelectedIndexChanged" CellPadding="3" GridLines="Vertical" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SeanceData" CssClass="auto-style1" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Module" HeaderText="Module" SortExpression="Module" />
                            <asp:BoundField DataField="Group" HeaderText="Group" ReadOnly="True" SortExpression="Group" />
                            <asp:BoundField DataField="Salle" HeaderText="Salle" SortExpression="Salle" />
                            <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                            <asp:BoundField DataField="Heure Début" HeaderText="Heure Début" ReadOnly="True" SortExpression="Heure Début" />
                            <asp:BoundField DataField="Heure Fin" HeaderText="Heure Fin" ReadOnly="True" SortExpression="Heure Fin" />
                        </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />                    
                </asp:GridView>
                </div>
                <asp:SqlDataSource ID="SeanceData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SeanceProf" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SalleDisponibleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SalleDisponible" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtDate" DbType="Date" Name="date" PropertyName="Text" />
                        <asp:ControlParameter ControlID="cmbHeureDebut" DbType="Time" Name="heureD" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="cmbHeureFin" DbType="Time" Name="heureF" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="GroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="GroupProf" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ModuleGroup" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="cmbGroup" Name="group" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ModuleProf" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="content_participer_seance">
                <br />
                <span id="Participer" runat="server"></span>
                <h3>Participation</h3>
                <asp:Label ID="lblGroupParticiper" CssClass="lbl_choix" runat="server">Group</asp:Label><asp:DropDownList ID="cmbGroupSeance" runat="server" CssClass="cmb_choix" Width="10%" AutoPostBack="True" DataSourceID="GroupData" DataTextField="ID_GROUP" DataValueField="ID_GROUP"></asp:DropDownList>
                <asp:Label ID="seance2" CssClass="lbl_choix" runat="server">Seane</asp:Label><asp:DropDownList ID="cmbSeance" runat="server" CssClass="cmb_choix" Width="10%" AutoPostBack="true" DataSourceID="SeanceGroupData" DataTextField="ID_SEANCE" DataValueField="ID_SEANCE"></asp:DropDownList>
                <div id="content_participer_seance" runat="server">
                    <asp:ImageButton ID="btnTelechargerPdf" runat="server" OnClick="btnTelechargerPdf_Click" CssClass="btn_pdf" ToolTip="Telecharger Sous Format PDF" ImageUrl="~/icons/icons8-pdf-file-format-53.png" Width="22px" />
                    <asp:GridView ID="ListParticipation" runat="server" CssClass="list_view" Width="70%"
                        AutoGenerateColumns="False" AutoGenerateSelectButton="True" OnSelectedIndexChanged="ListParticipation_SelectedIndexChanged"
                        CellPadding="3" GridLines="Vertical" DataSourceID="ListParticipationData" AllowSorting="True" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" >
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Numero" HeaderText="Numero" HeaderStyle-ForeColor="White" SortExpression="Numero" >
<HeaderStyle ForeColor="White"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Nom" HeaderText="Nom" HeaderStyle-ForeColor="White" SortExpression="Nom" >
<HeaderStyle ForeColor="White"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Prenom" HeaderText="Prenom" HeaderStyle-ForeColor="White" SortExpression="Prenom" >
<HeaderStyle ForeColor="White"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Presence" HeaderText="Presence" HeaderStyle-ForeColor="White" SortExpression="Presence" >
<HeaderStyle ForeColor="White"></HeaderStyle>
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>
                    <asp:Label ID="lblnumEtdParticiper" runat="server" CssClass="lbl_choixP" Text="Numero"></asp:Label><asp:TextBox ID="NumEtdParticiper" runat="server" Enabled="false" ></asp:TextBox>
                    <asp:Label ID="lblnumSeance" runat="server" CssClass="lbl_choixP" Text="Numero Seance"></asp:Label><asp:TextBox ID="NumSeanceParticiper" runat="server" Enabled="false" ></asp:TextBox>
                    <asp:CheckBox ID="Present" runat="server" CssClass="lbl_choixP" Text="Present" AutoPostBack="true" OnCheckedChanged="Present_CheckedChanged" TextAlign="Left"/>
                    <br />
                    <asp:Button ID="btnAjoutParticipant" CssClass="btnPresedent" runat="server" Text="Ajout" Visible="false"/>
                    <asp:Button ID="btnPresedentPS" CssClass="btnPresedent" runat="server" Text="Presedent" Visible="false"/>
                    <p id="deplacementEtdP" runat="server" Visible="false"><span id="indexNumEtdPS" runat="server">0</span>/<span id="nbrEtdparGroup" runat="server"></span></p>
                    <asp:Button ID="btnSuivantPS" CssClass="btnSuivant" runat="server" Text="Suivant" Visible="false" />
                    <asp:Button ID="btnModifierParticipant" CssClass="btnSuivant" runat="server" Text="Modifer" Visible="false" />
                    <br />
                    <asp:SqlDataSource ID="ListParticipationData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="PresenceParticiper" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cmbGroupSeance" Name="group" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="cmbSeance" Name="seance" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SeanceGroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ID_SEANCE] FROM [DETAIL_SEANCE] WHERE (([PROFESSEUR] = @PROFESSEUR) AND ([ID_GROUP] = @ID_GROUP))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNumero" Name="PROFESSEUR" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="cmbGroupSeance" Name="ID_GROUP" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label id="finExamen" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="content_exame">
                <br />
                <span id="exame"></span>
                <h3>Exame</h3>
                <div class="valdierExame">
                    <h5>Valider Exame</h5>
                    <br />
                    <!--<asp:Label ID="lblNumeroExame" runat="server">Numero Exame</asp:Label>
                    <asp:TextBox ID="txtNumeroExame" runat="server" TextMode="Number" CssClass="cmb_choix"></asp:TextBox>-->
                    <asp:Label ID="lblIDModule" runat="server">Module</asp:Label>
                    <asp:DropDownList ID="cmbModuleExame" runat="server" AutoPostBack="true" CssClass="cmb_choix" DataSourceID="ModuleData" DataTextField="ID_MODULE" DataValueField="ID_MODULE" OnSelectedIndexChanged="cmbModuleExame_SelectedIndexChanged"></asp:DropDownList>
                    <asp:Label ID="lblDate" runat="server">Date Exame</asp:Label>
                    <asp:TextBox ID="txtDateExame" runat="server" TextMode="Date" CssClass="cmb_choix"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnAjouterExame" runat="server" Text="Valider" CssClass="btnPresedent" OnClick="btnAjouterExame_Click"/>
                    <asp:Button ID="btnModifierExame" runat="server" Text="Modifier" CssClass="btnSuivant"/>
                    <asp:Button ID="btnSupprimerExame" runat="server" Text="Supprimer" CssClass="btnSuivant"/>
                </div>
                <div classe="Content_Note">
                    <h5>Notes Exame</h5>
                    <br />
                    <asp:Label ID="lblGroup2" CssClass="lbl_choix" runat="server">Group</asp:Label><asp:DropDownList ID="cmbExameGroup" runat="server" CssClass="cmb_choix" Width="10%" DataSourceID="GroupData" DataTextField="ID_GROUP" AutoPostBack="true" DataValueField="ID_GROUP"></asp:DropDownList>
                    <asp:Label ID="lblExame" CssClass="lbl_choix" runat="server">Exame</asp:Label><asp:DropDownList ID="cmbExame" runat="server" CssClass="cmb_choix" Width="10%" DataSourceID="ExameData" DataTextField="ID_EXAME" AutoPostBack="true" DataValueField="ID_EXAME"></asp:DropDownList>
                    <asp:GridView ID="ListNotesExame" runat="server" OnSelectedIndexChanged="ListNotesExame_SelectedIndexChanged" AutoGenerateSelectButton="True" CssClass="list_view" Width="70%" AutoGenerateColumns="False" CellPadding="3" GridLines="Vertical" DataKeyNames="NUMERO_ETUDIANT" DataSourceID="ListNotesExameData" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px">
                        <Columns>
                            <asp:BoundField DataField="NUMERO_ETUDIANT" HeaderText="Numero" SortExpression="NUMERO_ETUDIANT" InsertVisible="False" ReadOnly="True" />
                            <asp:BoundField DataField="NOM" HeaderText="Nom" SortExpression="NOM" />
                            <asp:BoundField DataField="PRENOM" HeaderText="Prenom" SortExpression="PRENOM" />
                            <asp:BoundField DataField="NOTE" HeaderText="Note" SortExpression="NOTE" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="ExameData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ExameProf" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="ListNotesExameData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ListNoteGroup" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cmbExameGroup" Name="group" PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="cmbExame" Name="exame" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <label id="lblNumEtd" runat="server" class="lbl_choix2" for="txtNumeroEtd">Numero Etudiant</label><asp:TextBox ID="txtNumeroEtd" runat="server" Enabled="False"></asp:TextBox>
                    <label class="lbl_choix2" for="txtExame">Numero Exame</label><asp:TextBox ID="txtExame" runat="server" Enabled="False"></asp:TextBox>
                    <label class="lbl_choix2" for="txtNote">Note</label><asp:TextBox ID="txtNote" runat="server"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnValiderNote" CssClass="btnPresedent" runat="server" Text="Ajout" OnClick="btnValiderNote_Click"/>
                    <asp:Button ID="btnModiferNote" CssClass="btnSuivant" runat="server" Text="Modifer" OnClick="btnModiferNote_Click"/>
                    <br />
                </div>
            </div>


        </div>


            </ContentTemplate>
        </asp:UpdatePanel>

        <script>
            let sidebar = document.getElementById("content-menu");
            let profil = document.getElementById("info");
            let mot_passe = document.getElementById("mot_passe");
            let bg_sidebar = document.getElementById("bg_sidebar");
            let content_profil = document.getElementById("content_profil");
            let content_mot_passe = document.getElementById("content_mot_passe");
            let tbl_info = document.getElementById("tbl_info");


            function OpenSidebar() {
                sidebar.style.left = "0px";
            }
            function CloseSidebar() {
                sidebar.style.left = "-350px";
            }
            function ActiverOpacity_0() {
                bg_sidebar.style.top = "-100%";
                bg_sidebar.style.opacity = "0";
                bg_sidebar.style.position = "absolute";
            }
            function ActiverOpacity_1() {
                bg_sidebar.style.top = "0%";
                bg_sidebar.style.opacity = "1";
                bg_sidebar.style.position = "fixed";
            }
            function OpenContentProfile() {
                content_profil.style.top = "10%";
                content_profil.style.opacity = "1";
                content_profil.style.position = "fixed";
            }
            function CloseContentProfile() {
                content_profil.style.top = "-100%";
                content_profil.style.opacity = "0";
                content_profil.style.position = "absolute";
            }

            /**************************************for open sidebar**************************************/
            document.getElementById("menu-btn").addEventListener("click", function () {
                OpenSidebar();
                ActiverOpacity_1();
                CloseContentProfile();
            });

            /**************************************for close sidebar**************************************/
            document.getElementById("exit").addEventListener("click", function () {
                CloseSidebar();
                ActiverOpacity_0();
            });

            /********************************************* for close content by profil and sidebar *********************************************/
            document.getElementById("bg_sidebar").addEventListener("click", function () {
                CloseSidebar();
                ActiverOpacity_0();
                CloseContentProfile();
            });
            /************************************* onclick btn profile for see the information *************************************/
            profil.addEventListener("click", function () {
                ActiverOpacity_1();
                OpenContentProfile();
                CloseSidebar();
            });
        </script>
        <!--<script src="JS/JavaScriptPageEtudiant.js"></script>-->
    </form>
</body>
</html>
