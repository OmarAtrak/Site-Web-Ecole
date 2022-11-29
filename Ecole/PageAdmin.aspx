<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageAdmin.aspx.cs" Inherits="Ecoule.PageAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Admin</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="bootstrap.min.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.js" type="text/javascript"></script>
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
            height: 100px;
            width: 100%;
            position: fixed;
            top: 0;
            background-color: #32758f;
            color: white;
        }

        nav > ul {
            float: right;
            height: 100%;
            width: 80%;
            text-align: right;
        }

        nav > ul > li {
            display: inline-block;
            margin-top: 20px;
            margin-right: 30px;
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

        .content_profil > table {
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

        .content_profil > table > tr > th {
            padding: 20px 5px;
            text-align: center;
            font-weight: 400;
            font-size: 24px;
            text-transform: uppercase;
        }

        .content_profil > table > tr > td {
            padding: 10px;
            text-align: center;
            font-weight: 400;
            font-size: 20px;
            border-bottom: .4px solid rgba(0,0,0,.4);
        }

        .profil {
            float: left;
            margin-top: 5px;
            margin-left: 20px;
            transform: rotate(90deg);
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
            margin-left: 50px;
            border: .4px solid rgba(0,0,0,0.4);
            text-align:center;
            height:70px;
            overflow: auto;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 250px;
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

        .sidebar > ul > li:hover:active{
            background-color: #00b7c3;
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
            margin-top: 10px;
            border: solid #00b7c3 2px;
            border-left: none;
            width: 97%;
        }

        .lblemail img {
            margin-right: 1px;
        }

        .icon {
            /*transform : translateY(-20px);*/
            margin-top:10px;
            margin-right: 20px;
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
        table {
            margin-left:100px;
        }
        .auto-style1 {
            width: 200px;
        }
        .auto-style2 {
            width: 155px;
        }
        .auto-style3 {
            margin-left: 5px;
        }
        .auto-style4 {
            width:70%;
            margin-left:30px;
        }
        .auto-style5 {
            width: 157px;
        }
        .auto-style6 {
            width: 39%
        }
        .btnsOperation {
            float:left;
            margin-left:10px;
            width:100px;
        }
        .ListFloat {
            float:left;
            margin-right:100px;
        }
        .txtRecherche {
            margin:20px 10px 20px 50px;
        }
        .btnRecherche {
            transform: translateY(20px);
        }
        .auto_style8 {
            width: 250px;
        }
        .auto_style9 {
            width: 50px;
        }
        .td_vide {
            height:20px;
        }
        .auto-style8 {
            float: left;
            margin-right: 100px;
            height: 450px;
        }
        .ListFloatRight {
            float:right;
            margin-right:60px;
        }
        #content {
            margin-left:250px;
            /*transition:all 0.5s;*/
        }
        .iconRecherche {
            margin-left:-37px;
            margin-bottom:-7px;
            /*transform:translate(-37px,7px);*/
        }
        .infos {
            width:15%;
            height:90%;
            margin-top:5px;
            margin-right:20px;
            border-radius:5px;
            text-align:center;
            float:right;
            background-color:palevioletred;
        }
        .infos > p {
            border-top: solid 1px rgba(255,255,255,.5);
        }
        .infos > span {
            display:block;
            font-size:20px;
            font-weight:900;
            margin-top:-10px;
        }
        .infosEtd {
            background-color:rgba(255,255,255,.5);
        }
        .infosProf {
            background-color:rgba(114,222,211,.5);
        }
        .infosGroup {
            background-color:rgba(94,255,94,.4);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav>
            <div id="infoEtd" class="infos infosEtd"><img src="icons/icons8-christmas-star-50.png" width="30px"/><p>Etudiant</p><span id="nbrEtd" runat="server"></span></div>
            <div id="infoProf" class="infos infosProf"><img src="icons/icons8-teacher-64.png" width="30px"/><p>Professeur</p><span id="nbrProf" runat="server"></span></div>
            <div id="infoGroup" class="infos infosGroup"><img src="icons/icons8-user-groups-50.png" width="30px"/><p>Group</p><span id="nbrGroup" runat="server"></span></div>
            
            <div id="bg_sidebar" runat="server" class="bg_sidebar"></div>
            <div class="menu">
                <a id="menu-btn" class="profil">|||</a>
                <div id="content-menu" class="sidebar">
                    <!--<span class="exit-menu"><a id="exit">X</a></span>-->
                    <!--<div class="lblemail"><img src="icons/user.png" height="30px"/><asp:label ID="emailEtudiant" runat="server" CssClass="align"></asp:label></div>-->
                    <div class="lblemail"><img src="icons/user.png" height="25px"/><asp:label ID="emailAdmin" runat="server" CssClass="align">atrak.omar1@admin.ma</asp:label></div>
                    <ul>
                        <li><a id="contentEtd" href="#etd">Etudiant</a></li>
                        <li><a id="contentProf" href="#prof">Professeur</a></li>
                        <li><a id="contentSectionGroup" href="#section">Section et Group</a></li>
                        <li><a id="contentModule" href="#module">Module</a></li>
                        <li><a href="#module_section">Module Par Section</a></li>
                        <li><a id="contentSalle" href="#salle">Salle</a></li>
                        <li><a id="contentSeance" href="#seance">Seance</a></li>
                        <li><a id="contentDetailSeance" href="#detail_seance">Detail seance</a></li>
                        <li id="info">
                            <a id="profil"><img id="btnImgProfil" src="icons/login.png" class="icon" width="30px" title="Profil" /></a>
                            <asp:ImageButton ID="btnImgChangerMotPasse" runat="server" ImageUrl="~/icons/lock.png" CssClass="icon" Width="30px" OnClick="ChangerMotPasse_Click" ToolTip="Changer Mot de Passe" />
                            <asp:ImageButton ID="btnImgDeconnecter" runat="server" ImageUrl="~/icons/logout.png" CssClass="icon" Width="30px" OnClick="btnImgDeconnecter_Click" ToolTip="Deconnecter" />
                        </li>
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
                </tr>
            </table>
        </div>
        <div id="content">
            <!--List Etudiant-->
            <div>
                <br />
                <span id="etd"></span>
                <h3>Etudiant</h3>
                <div>
                <table class="auto-style4" id="tblEtudiant" runat="server">
                    <tr>
                        <td class="auto-style1">Nom</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtNomEtd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Prenom</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtPrenomEtd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Group</td>
                        <td class="auto-style2">
                            <asp:DropDownList ID="txtGroupEtd" runat="server" Width="186px" DataSourceID="GroupEtdData" DataTextField="ID_GROUP" DataValueField="ID_GROUP"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Date de Naissance</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtDateEtd" runat="server" TextMode="Date" Width="186px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Telephone</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtTeleEtd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Mot de Passe</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtMotPasseEtd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Adresse</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtAdresseEtd" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Sexe</td>
                        <td class="auto-style2">
                            <asp:RadioButtonList ID="sexeEtd" runat="server" CssClass="auto-style3" RepeatDirection="Horizontal">
                                <asp:ListItem>M</asp:ListItem>
                                <asp:ListItem>F</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="auto-style1">
                            <asp:Button ID="btnAjoutEtd" CssClass="btnsOperation btn_ajout" runat="server" Text="Ajout" OnClick="btnAjoutEtd_Click" Width="100px" />
                            <asp:Button ID="btnModifier" CssClass="btnsOperation btn_modifier" runat="server" Text="Modifer" Width="100px" OnClick="btnModifier_Click" />
                            <asp:Button ID="btnSupprimer" CssClass="btnsOperation btn_supp" runat="server" Text="Suprimer" Width="100px" OnClick="btnSupprimer_Click" OnClientClick="return ConfirmDelete(this);"/>
                            <asp:Button ID="btnInsialiser" CssClass="btnsOperation btn_insialiser" runat="server" Text="Insialiser" Width="100px" OnClick="btnInsialiser_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1"><asp:Label id="lblmsg" runat="server" Text=""></asp:Label></td>
                        <td class="auto-style2">
                            <asp:SqlDataSource ID="GroupEtdData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ID_GROUP] FROM [GROUP]"></asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <asp:TextBox ID="txtRecherchEtd" CssClass="txtRecherche" runat="server"></asp:TextBox><asp:ImageButton ID="btnRechercheEtd" CssClass="iconRecherche" runat="server" ImageUrl="~/icons/recherche.png" Width="25px" />
                <asp:GridView id="ListEtudiant" runat="server" Width="90%" CssClass="list"
                    AutoGenerateColumns="False" OnSelectedIndexChanged="ListEtudiant_SelectedIndexChanged"
                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="NUMERO_ETUDIANT" DataSourceID="EtudiantData" AutoGenerateSelectButton="True" AllowSorting="True">                
                    <Columns>
                        <asp:BoundField DataField="NUMERO_ETUDIANT" HeaderText="Numero" InsertVisible="False" ReadOnly="True" SortExpression="NUMERO_ETUDIANT" />
                        <asp:BoundField DataField="ID_GROUP" HeaderText="Group" SortExpression="ID_GROUP" />
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
                <asp:SqlDataSource ID="EtudiantData" runat="server" ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [ETUDIANT] WHERE [NUMERO_ETUDIANT] = @original_NUMERO_ETUDIANT AND [ID_GROUP] = @original_ID_GROUP AND [NOM] = @original_NOM AND [PRENOM] = @original_PRENOM AND [TELEPHONE] = @original_TELEPHONE AND [DATENAISSANCE] = @original_DATENAISSANCE AND [MOT_PASSE_ETUDIANT] = @original_MOT_PASSE_ETUDIANT AND [ADRESSE] = @original_ADRESSE AND [SEXE] = @original_SEXE" 
            InsertCommand="INSERT INTO [ETUDIANT] ([ID_GROUP], [NOM], [PRENOM], [TELEPHONE], [DATENAISSANCE], [MOT_PASSE_ETUDIANT], [ADRESSE], [SEXE]) VALUES (@ID_GROUP, @NOM, @PRENOM, @TELEPHONE, @DATENAISSANCE, @MOT_PASSE_ETUDIANT, @ADRESSE, @SEXE)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="select NUMERO_ETUDIANT,ID_GROUP,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,10) as Date,MOT_PASSE_ETUDIANT,EMAIL,ADRESSE,SEXE from ETUDIANT" 
            UpdateCommand="UPDATE [ETUDIANT] SET [ID_GROUP] = @ID_GROUP, [NOM] = @NOM, [PRENOM] = @PRENOM, [TELEPHONE] = @TELEPHONE, [DATENAISSANCE] = @DATENAISSANCE, [MOT_PASSE_ETUDIANT] = @MOT_PASSE_ETUDIANT, [ADRESSE] = @ADRESSE, [SEXE] = @SEXE WHERE [NUMERO_ETUDIANT] = @original_NUMERO_ETUDIANT AND [ID_GROUP] = @original_ID_GROUP AND [NOM] = @original_NOM AND [PRENOM] = @original_PRENOM AND [TELEPHONE] = @original_TELEPHONE AND [DATENAISSANCE] = @original_DATENAISSANCE AND [MOT_PASSE_ETUDIANT] = @original_MOT_PASSE_ETUDIANT AND [ADRESSE] = @original_ADRESSE AND [SEXE] = @original_SEXE">
            <DeleteParameters>
                <asp:Parameter Name="original_NUMERO_ETUDIANT" Type="Int32" />
                <asp:Parameter Name="original_ID_GROUP" Type="Int32" />
                <asp:Parameter Name="original_NOM" Type="String" />
                <asp:Parameter Name="original_PRENOM" Type="String" />
                <asp:Parameter Name="original_TELEPHONE" Type="String" />
                <asp:Parameter DbType="Date" Name="original_DATENAISSANCE" />
                <asp:Parameter Name="original_MOT_PASSE_ETUDIANT" Type="String" />
                <asp:Parameter Name="original_ADRESSE" Type="String" />
                <asp:Parameter Name="original_SEXE" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ID_GROUP" Type="Int32" />
                <asp:Parameter Name="NOM" Type="String" />
                <asp:Parameter Name="PRENOM" Type="String" />
                <asp:Parameter Name="TELEPHONE" Type="String" />
                <asp:Parameter DbType="Date" Name="DATENAISSANCE" />
                <asp:Parameter Name="MOT_PASSE_ETUDIANT" Type="String" />
                <asp:Parameter Name="ADRESSE" Type="String" />
                <asp:Parameter Name="SEXE" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ID_GROUP" Type="Int32" />
                <asp:Parameter Name="NOM" Type="String" />
                <asp:Parameter Name="PRENOM" Type="String" />
                <asp:Parameter Name="TELEPHONE" Type="String" />
                <asp:Parameter DbType="Date" Name="DATENAISSANCE" />
                <asp:Parameter Name="MOT_PASSE_ETUDIANT" Type="String" />
                <asp:Parameter Name="ADRESSE" Type="String" />
                <asp:Parameter Name="SEXE" Type="String" />
                <asp:Parameter Name="original_NUMERO_ETUDIANT" Type="Int32" />
                <asp:Parameter Name="original_ID_GROUP" Type="Int32" />
                <asp:Parameter Name="original_NOM" Type="String" />
                <asp:Parameter Name="original_PRENOM" Type="String" />
                <asp:Parameter Name="original_TELEPHONE" Type="String" />
                <asp:Parameter DbType="Date" Name="original_DATENAISSANCE" />
                <asp:Parameter Name="original_MOT_PASSE_ETUDIANT" Type="String" />
                <asp:Parameter Name="original_ADRESSE" Type="String" />
                <asp:Parameter Name="original_SEXE" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
                </div>
            </div>
            <!--List Prof-->
            <div>
                <br />
                <span id="prof"></span>
                <h3>Professeur</h3>
                <asp:TextBox ID="txtRechercheProf" CssClass="txtRecherche" runat="server"></asp:TextBox><asp:ImageButton ID="btnRechercheProf" runat="server" ImageUrl="~/icons/Recherche.jpeg" Width="20px" />
                <div>
                    <asp:GridView ID="ListProf" runat="server" Width="90%" CssClass="list" BorderColor="#CCCCCC" BorderStyle="None" 
                        BorderWidth="1px" CellPadding="3" AutoGenerateColumns="False" AutoGenerateSelectButton="True" 
                        OnSelectedIndexChanged="ListProf_SelectedIndexChanged" DataSourceID="ProfData" AllowSorting="True">
                        <Columns>
                            <asp:BoundField DataField="MATRICULE" HeaderText="Numero" ReadOnly="True" SortExpression="MATRICULE" />
                            <asp:BoundField DataField="NOM" HeaderText="Nom" SortExpression="NOM" />
                            <asp:BoundField DataField="PRENOM" HeaderText="Prenom" SortExpression="PRENOM" />
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
                    <br />
                    <table class="auto-style6">
                        <tr>
                            <td class="auto-style1">Numero</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtNumeroProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Nom</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtNomProf" runat="server" Width="186px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Prenom</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtPrenomProf" runat="server" Width="186px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Date de Naissance</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtDateProf" TextMode="Date" runat="server" Width="186px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Telephone</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtTeleProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Mot de Passe</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtMotPasseProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Adresse</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtAdresseProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Salire</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtSalaireProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Gmail</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtGmailProf" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">Sexe</td>
                            <td class="auto-style5">
                                <asp:RadioButtonList ID="sexeProf" runat="server" CssClass="auto-style3" RepeatDirection="Horizontal">
                                    <asp:ListItem>M</asp:ListItem>
                                    <asp:ListItem>F</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="auto-style1">
                                <asp:Button ID="btnAjoutProf" runat="server" Text="Ajout" OnClick="btnAjoutProf_Click" Width="100px" />
                                <asp:Button ID="btnModiferProf" runat="server" Text="Modifer" Width="100px" OnClick="btnModiferProf_Click" />
                                <asp:Button ID="btnSupprimerProf" runat="server" Text="Suprimer" Width="100px" OnClick="btnSupprimerProf_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="auto-style1">
                                <asp:Label ID="lblmssgProf" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <span id="finProf" runat="server"></span>
                    <asp:SqlDataSource ID="ProfData" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT MATRICULE,NOM,PRENOM,TELEPHONE,LEFT(DATENAISSANCE,11) as [Date] ,EMAIL,MOT_PASSE_PROF,SEXE,ADRESSE,SALAIRE,GMAIL FROM [PROFESSEUR]" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [PROFESSEUR] WHERE [MATRICULE] = @original_MATRICULE AND [NOM] = @original_NOM AND [PRENOM] = @original_PRENOM AND [DATENAISSANCE] = @original_DATENAISSANCE AND [TELEPHONE] = @original_TELEPHONE AND [MOT_PASSE_PROF] = @original_MOT_PASSE_PROF AND (([SEXE] = @original_SEXE) OR ([SEXE] IS NULL AND @original_SEXE IS NULL)) AND (([ADRESSE] = @original_ADRESSE) OR ([ADRESSE] IS NULL AND @original_ADRESSE IS NULL)) AND [SALAIRE] = @original_SALAIRE AND [GMAIL] = @original_GMAIL" 
            InsertCommand="INSERT INTO [PROFESSEUR] ([MATRICULE], [NOM], [PRENOM], [DATENAISSANCE], [TELEPHONE], [MOT_PASSE_PROF], [SEXE], [ADRESSE], [SALAIRE], [GMAIL]) VALUES (@MATRICULE, @NOM, @PRENOM, @DATENAISSANCE, @TELEPHONE, @MOT_PASSE_PROF, @SEXE, @ADRESSE, @SALAIRE, @GMAIL)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [PROFESSEUR] SET [NOM] = @NOM, [PRENOM] = @PRENOM, [DATENAISSANCE] = @DATENAISSANCE, [TELEPHONE] = @TELEPHONE, [MOT_PASSE_PROF] = @MOT_PASSE_PROF, [SEXE] = @SEXE, [ADRESSE] = @ADRESSE, [SALAIRE] = @SALAIRE, [GMAIL] = @GMAIL WHERE [MATRICULE] = @original_MATRICULE AND [NOM] = @original_NOM AND [PRENOM] = @original_PRENOM AND [DATENAISSANCE] = @original_DATENAISSANCE AND [TELEPHONE] = @original_TELEPHONE AND [MOT_PASSE_PROF] = @original_MOT_PASSE_PROF AND (([SEXE] = @original_SEXE) OR ([SEXE] IS NULL AND @original_SEXE IS NULL)) AND (([ADRESSE] = @original_ADRESSE) OR ([ADRESSE] IS NULL AND @original_ADRESSE IS NULL)) AND [SALAIRE] = @original_SALAIRE AND [GMAIL] = @original_GMAIL">
            <DeleteParameters>
                <asp:Parameter Name="original_MATRICULE" Type="Int32" />
                <asp:Parameter Name="original_NOM" Type="String" />
                <asp:Parameter Name="original_PRENOM" Type="String" />
                <asp:Parameter Name="original_DATENAISSANCE" Type="DateTime" />
                <asp:Parameter Name="original_TELEPHONE" Type="String" />
                <asp:Parameter Name="original_MOT_PASSE_PROF" Type="String" />
                <asp:Parameter Name="original_SEXE" Type="String" />
                <asp:Parameter Name="original_ADRESSE" Type="String" />
                <asp:Parameter Name="original_SALAIRE" Type="Decimal" />
                <asp:Parameter Name="original_GMAIL" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MATRICULE" Type="Int32" />
                <asp:Parameter Name="NOM" Type="String" />
                <asp:Parameter Name="PRENOM" Type="String" />
                <asp:Parameter Name="DATENAISSANCE" Type="DateTime" />
                <asp:Parameter Name="TELEPHONE" Type="String" />
                <asp:Parameter Name="MOT_PASSE_PROF" Type="String" />
                <asp:Parameter Name="SEXE" Type="String" />
                <asp:Parameter Name="ADRESSE" Type="String" />
                <asp:Parameter Name="SALAIRE" Type="Decimal" />
                <asp:Parameter Name="GMAIL" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="NOM" Type="String" />
                <asp:Parameter Name="PRENOM" Type="String" />
                <asp:Parameter Name="DATENAISSANCE" Type="DateTime" />
                <asp:Parameter Name="TELEPHONE" Type="String" />
                <asp:Parameter Name="MOT_PASSE_PROF" Type="String" />
                <asp:Parameter Name="SEXE" Type="String" />
                <asp:Parameter Name="ADRESSE" Type="String" />
                <asp:Parameter Name="SALAIRE" Type="Decimal" />
                <asp:Parameter Name="GMAIL" Type="String" />
                <asp:Parameter Name="original_MATRICULE" Type="Int32" />
                <asp:Parameter Name="original_NOM" Type="String" />
                <asp:Parameter Name="original_PRENOM" Type="String" />
                <asp:Parameter Name="original_DATENAISSANCE" Type="DateTime" />
                <asp:Parameter Name="original_TELEPHONE" Type="String" />
                <asp:Parameter Name="original_MOT_PASSE_PROF" Type="String" />
                <asp:Parameter Name="original_SEXE" Type="String" />
                <asp:Parameter Name="original_ADRESSE" Type="String" />
                <asp:Parameter Name="original_SALAIRE" Type="Decimal" />
                <asp:Parameter Name="original_GMAIL" Type="String" />
            </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
            <!--List Section , List Group , List Module-->
            <div>
                    <!--List Section-->
                    <div class="auto-style8">
                        <br />
                        <span id="section"></span>
                        <h3>Section</h3>
                        <div>
                            <asp:GridView ID="ListSection" runat="server" CssClass="list" 
                                AutoGenerateColumns="False" AutoGenerateSelectButton="true" OnSelectedIndexChanged="ListSection_SelectedIndexChanged"
                                DataKeyNames="NUMERO_SECTION" DataSourceID="SectionData">
                                <Columns>
                                    <asp:BoundField DataField="NUMERO_SECTION" HeaderText="Numero" ReadOnly="True" SortExpression="NUMERO_SECTION" />
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
                            <table id="tblSection" runat="server" class="auto-style4">
                                <tr>
                                    <td class="auto-style1">Numero Section</td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="txtNumeroSection" runat="server" Width="186px" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnAjoutSection" runat="server" Text="Ajout" Width="186px" OnClick="btnAjoutSection_Click"/>
                                        <asp:Button ID="btnSuprimerSection" runat="server" Text="Supprimer" Width="186px" OnClick="btnSuprimerSection_Click"/>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="SectionData" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            DeleteCommand="DELETE FROM [SECTION] WHERE [NUMERO_SECTION] = @original_NUMERO_SECTION" 
                            InsertCommand="INSERT INTO [SECTION] ([NUMERO_SECTION]) VALUES (@NUMERO_SECTION)" 
                            OldValuesParameterFormatString="original_{0}" 
                            SelectCommand="SELECT * FROM [SECTION] order by NUMERO_SECTION">
                            <DeleteParameters>
                                <asp:Parameter Name="original_NUMERO_SECTION" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="NUMERO_SECTION" Type="Int32" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                            <br />
                        </div>
                    </div>
                    <!--List Group-->
                    <div class="ListFloat">
                        <br />
                        <span id="group"></span>
                        <h3>Group</h3>
                        <asp:TextBox ID="txtRecherchGroup" CssClass="txtRecherche" runat="server"></asp:TextBox><asp:ImageButton ID="btnRechercheGroup" runat="server" ImageUrl="~/icons/Recherche.jpeg" Width="20px" />
                        <div>
                            <asp:GridView ID="ListGroup" runat="server" CssClass="list"
                                AutoGenerateColumns="False" AutoGenerateSelectButton="true"
                                OnSelectedIndexChanged="ListGroup_SelectedIndexChanged"
                                DataKeyNames="ID_GROUP" DataSourceID="GroupData">
                                <Columns>
                                    <asp:BoundField DataField="ID_GROUP" HeaderText="Numero" ReadOnly="True" SortExpression="ID_GROUP" />
                                    <asp:BoundField DataField="NUMERO_SECTION" HeaderText="Section" SortExpression="NUMERO_SECTION" />
                                    <asp:BoundField DataField="NUMERO_GROUP" HeaderText="Numero Group" SortExpression="NUMERO_GROUP" />
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
                            <table class="auto-style4" id="Table1" runat="server">
                                <tr>
                                    <td class="auto_style8">ID</td>
                                    <td class="auto_style9">
                                        <asp:TextBox ID="txtIDGroup" runat="server" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto_style8">Section</td>
                                    <td class="auto_style9">
                                        <asp:DropDownList Width="186px" ID="txtSectionGroup" runat="server" DataSourceID="SectionGroupData" DataTextField="NUMERO_SECTION" DataValueField="NUMERO_SECTION"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto_style8">Numero Group</td>
                                    <td class="auto_style9">
                                        <asp:TextBox ID="txtNumeroGroup" runat="server" TextMode="Number"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="td_vide"></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="btnAjoutGroup" runat="server" OnClick="btnAjoutGroup_Click" Text="Ajout" Width="100px" />
                                        <asp:Button ID="btnModifierGroup" runat="server" OnClick="btnModifierGroup_Click" Text="Modifer" Width="100px" />
                                        <asp:Button ID="btnSupprimerGroup" runat="server" OnClick="btnSupprimerGroup_Click" Text="Supprimer" Width="100px" />
                                    </td>
                                </tr>
                            </table>
                            <span id="finGroup" runat="server"></span>
                            <asp:SqlDataSource ID="GroupData" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [GROUP] WHERE [ID_GROUP] = @original_ID_GROUP AND [NUMERO_SECTION] = @original_NUMERO_SECTION AND [NUMERO_GROUP] = @original_NUMERO_GROUP" InsertCommand="INSERT INTO [GROUP] ([ID_GROUP], [NUMERO_SECTION], [NUMERO_GROUP]) VALUES (@ID_GROUP, @NUMERO_SECTION, @NUMERO_GROUP)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [GROUP]" UpdateCommand="UPDATE [GROUP] SET [NUMERO_SECTION] = @NUMERO_SECTION, [NUMERO_GROUP] = @NUMERO_GROUP WHERE [ID_GROUP] = @original_ID_GROUP AND [NUMERO_SECTION] = @original_NUMERO_SECTION AND [NUMERO_GROUP] = @original_NUMERO_GROUP">
                                <DeleteParameters>
                                    <asp:Parameter Name="original_ID_GROUP" Type="Int32" />
                                    <asp:Parameter Name="original_NUMERO_SECTION" Type="Int32" />
                                    <asp:Parameter Name="original_NUMERO_GROUP" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID_GROUP" Type="Int32" />
                                    <asp:Parameter Name="NUMERO_SECTION" Type="Int32" />
                                    <asp:Parameter Name="NUMERO_GROUP" Type="Int32" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="NUMERO_SECTION" Type="Int32" />
                                    <asp:Parameter Name="NUMERO_GROUP" Type="Int32" />
                                    <asp:Parameter Name="original_ID_GROUP" Type="Int32" />
                                    <asp:Parameter Name="original_NUMERO_SECTION" Type="Int32" />
                                    <asp:Parameter Name="original_NUMERO_GROUP" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SectionGroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [NUMERO_SECTION] FROM [SECTION]"></asp:SqlDataSource>
                        </div>
                    </div>    
                    <!--List Module-->
                    <div class="ListFloatRight">
                    <br />
                    <span id="module"></span>
                    <h3>Module</h3>
                    <asp:TextBox ID="txtRecherchModule" CssClass="txtRecherche" runat="server"></asp:TextBox><asp:ImageButton ID="btnRechercheModule" runat="server" ImageUrl="~/icons/Recherche.jpeg" Width="20px" />
                    <div>
                        <asp:GridView ID="ListModule" runat="server" CssClass="list" AutoGenerateColumns="False" 
                            AutoGenerateSelectButton="true" OnSelectedIndexChanged="ListModule_SelectedIndexChanged"
                            DataKeyNames="ID_MODULE" DataSourceID="ModuleData">
                            <Columns>
                                <asp:BoundField DataField="ID_MODULE" HeaderText="ID" ReadOnly="True" SortExpression="ID_MODULE" />
                                <asp:BoundField DataField="LIBELLE" HeaderText="Libelle" SortExpression="LIBELLE" />
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
                        <table class="auto-style4" id="tblModule" runat="server">
                        <tr>
                            <td class="auto_style8">ID</td>
                            <td class="auto_style9">
                                <asp:TextBox ID="txtIdModule" runat="server" TextMode="Number"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto_style8">Libelle</td>
                            <td class="auto_style9">
                                <asp:TextBox ID="txtLibelleModule" runat="server" Width="186px" CssClass="mt-0"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnAjoutModule" runat="server" OnClick="btnAjoutModule_Click" Text="Ajout" Width="100px" />
                                <asp:Button ID="btnModifierModule" runat="server" OnClick="btnModifierModule_Click" Text="Modifer" Width="100px" />
                                <asp:Button ID="btnSupprimerModule" CssClass="btn_supp" runat="server" OnClick="btnSupprimerModule_Click" Text="Supprimer" Width="100px" />
                            </td>
                        </tr>
                    </table>
                        <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MODULE]"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>



        <script src="JS/jquery-3.6.0.min.js" type="text/javascript"></script>
        <script>
            let sidebar = document.getElementById("content-menu");
            let profil = document.getElementById("info");
            let mot_passe = document.getElementById("mot_passe");
            let bg_sidebar = document.getElementById("bg_sidebar");
            let content_profil = document.getElementById("content_profil");
            let content_mot_passe = document.getElementById("content_mot_passe");
            let tbl_info = document.getElementById("tbl_info");
            let content = document.getElementById("content");


            function OpenSidebar() {
                sidebar.style.left = "0px";
                content.style.marginLeft = "250px";
            }
            function CloseSidebar() {
                sidebar.style.left = "-350px";
                content.style.marginLeft = "0px";
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

            /**************************************for open sidebar*************************************
            document.getElementById("menu-btn").addEventListener("click", function () {
                OpenSidebar();
                //ActiverOpacity_1();
                CloseContentProfile();
            });*/

            /**************************************for close sidebar*************************************
            document.getElementById("exit").addEventListener("click", function () {
                CloseSidebar();
                //ActiverOpacity_0();
            });

            //pour changer le color de fond de le choix selectionner
            let option = document.querySelectorAll("div ul li");
            for (var i = 0; i < option.length; i++) {
                option[i].addEventListener("click", function () {
                       
                });
            }*/


            /********************************************* for close content by profil and sidebar *********************************************/
            document.getElementById("bg_sidebar").addEventListener("click", function () {
                //CloseSidebar();
                ActiverOpacity_0();
                CloseContentProfile();
            });
            /************************************* onclick btn profile for see the information *************************************/
            profil.addEventListener("click", function () {
                ActiverOpacity_1();
                OpenContentProfile();
                //CloseSidebar();
            });






            /***********************************  Pour content of page  *************************************/




            // sweet alert for delete
            var object = { status: false, ele: null };

            function ConfirmDelete(ev) {
                if (object.status) { return true; };
                swal({
                    title: "Vous-etes sur?",
                    text: "Vous Voullez Supprimer",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonClass: "btn-danger",
                    confirmButtonText: "Oui, Supprimer!",
                    closeOnConfirm: true
                },
                    function () {
                        object.status = true;
                        object.ele = ev;
                        object.ele.click();
                    });
                return false;
            }
        </script>
        <!--<script src="JS/JavaScriptPageEtudiant.js"></script>-->
        
    </form>
</body>
</html>
