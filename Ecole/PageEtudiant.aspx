<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="PageEtudiant.aspx.cs" Inherits="Ecoule.PageEtudiant" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page Etudiant</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500,300,700" />
    <!--<link rel="stylesheet" href="Style/StylePageEtudiant.css" />-->
    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:400,500,300,700);

* {
    margin:0px;
    padding:0px;
    box-sizing:border-box;
}
body {
    /*background: linear-gradient(to right, #7ce0ea, #71c6ce);*/
    font-family: 'Roboto', sans-serif;
    background-color: #e2e5a7;

}
/*menu pranciapale*/
nav {
    margin:0px;
    padding:0px;
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

nav > ul > li > a {
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
    padding: 20px 15px;
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
}

.profil {
    float: left;
    margin-top: 5px;
    margin-left: 20px;
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
    border: .4px solid rgba(0,0,0,0.5);
    border-bottom:none;
}

.list tr th{
    word-wrap: break-word;
}

.list tr td{
    border: .4px solid rgba(0,0,0,0.5);
    word-wrap: break-word;
}

.Boitelist {
    margin: auto;
    width: 70%;
    margin-bottom: 50px;
}

h3 {
    margin-top: 100px;
    margin-left: 50px;
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
    margin-left: 0px;
    padding: 0px;
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

#btn_exit, #btn_UpdateMotPasse {
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

.content_profil {
    position: absolute;
    top: -100%;
    left: 5%;
    width: 90%;
    height: 400px;
    background-color: white;
    border-radius: 15px;
    box-sizing: border-box;
    padding: 10px;
    transition: all .5s;
    opacity: 0;
    min-width:250px;
}

.content_profil table tr td {
    text-transform:capitalize;
    overflow-wrap: break-word;
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

.btn_updatePassword {
    border:none;
    border-radius: 5px;
    width: 200px;
    height: 50px;
    background-color:#b7b7b5;
}
        .BoiteEmploi {
            width:95%;
            margin:auto;
        }
        .BoiteEmploi table tr th {
            font-size:18px;
            font-weight:500;
        }
        .choix_boitelist {
            text-align:center;
            margin-bottom:30px;
        }
        #Annee,#semestre {
            margin-left:20px;
            height:30px;
            width:130px;
        }
        #Annee {
            margin-right:200px;
        }
        .tbl_Note {
            background-color: #ededed;
            border: .4px solid rgba(0,0,0,0.5);
            border-top: none;
        }
        .tbl_Note tr td{
            border: .4px solid rgba(0,0,0,0.5);
        }
        .tblProf {
            border:solid .1px rgb(164 163 163);
        }
        .tblProf a {
            color:blue;
        }
        .tblProf a:hover {
            text-decoration:underline;
        }
        .tblProf th {
            background-color:#507CD1;
            font-weight:800;
            color:white;
        }
        .tblProf td {
            background-color:#EFF3FB;
            color:black;
        }
        .tblProf img {
            float:right;
        }
        .btn_pdf {
            margin-left: 97%;
            margin-bottom: -40px;
        }
        #msgEmploi {
            margin-left:10%;
        }
        #closeProfile {
            float:right;
            position:absolute;
            left:96%;
            top:-0.5%;
            cursor:pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <nav>
            <ul>
                <li><a href="#note">Notes</a></li>
                <li><a href="#emploi">Emploi de Temps</a></li>
                <li><a href="#exame">Exames</a></li>
                <li><a href="#contactprof">Contact Mon Prof</a></li>
            </ul>
            <div id="bg_sidebar" runat="server" class="bg_sidebar"></div>
            <div class="menu">
                <a id="menu-btn" class="profil"><img src="icons/icons8-menu-49.png" width="50" /></a>
                <div id="content-menu" class="sidebar">
                    <span class="exit-menu"><a id="exit">X</a></span>
                    <div class="lblemail"><img src="icons/user.png" height="30"/><asp:label ID="emailEtudiant" runat="server" CssClass="align"></asp:label></div>
                    <ul>
                        <li id="info"><a><img src="icons/login.png" class="icon" height="30"/>Profil</a></li>
                        <li><img class="icon" src="icons/lock.png"   height="30"/><asp:Button id="btn_UpdateMotPasse" runat="server" Text="Changer Mot de Passe" OnClick="btn_UpdateMotPasse_Click"/></li>
                        <li><img class="icon" src="icons/logout.png" height="30"/><asp:Button id="btn_exit" runat="server" Text="Déconnecter" OnClick="btn_exit_Click"/></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div id="content_profil" class="content_profil">
        <img id="closeProfile" src="icons/icons8-close-64.png" title="Fermer" width="50" />
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
                    <td class="right">Group:</td>
                    <td class="left"><asp:label ID="lblGroup" runat="server"></asp:label></td>
                </tr>
            </table>
        </div>
        <asp:UpdatePanel ID="up" runat="server">
            <ContentTemplate>
                <div id="content">
            <br />
            <span id="note"></span>
            <h3>Mes Notes</h3>
            <div class="choix_boitelist">
                <label for="Annee">Annee</label><asp:DropDownList ID="Annee" runat="server" Width="150px" CssClass="align" AutoPostBack="True" DataSourceID="AnneesData" DataTextField="y" DataValueField="y">
                </asp:DropDownList>
                <label for="semestre">Semestre</label><asp:DropDownList ID="semestre" runat="server" Width="150px" CssClass="align" AutoPostBack="true">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="Boitelist" id="notes" runat="server">

                <!--<asp:ImageButton ID="btnTelecharger" runat="server" OnClick="btnTelecharger_Click1" CssClass="btn_pdf" ImageUrl="~/icons/icons8-pdf-file-format-53.png" Width="25px" />-->
                <asp:GridView ID="ListNotes" runat="server" AutoGenerateColumns="False" Height="700px" CssClass="list" DataSourceID="DataListNotes" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Module" HeaderText="Module" SortExpression="Module" />
                        <asp:BoundField DataField="Note" HeaderText="Note" ReadOnly="True" SortExpression="Note" />
                        <asp:BoundField DataField="Observation" HeaderText="Observation" ReadOnly="True" SortExpression="Observation" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <table class="tbl_Note" id="tblNote" runat="server">
                    <%--<tr>
                        <td>Moynne Generale</td>
                        <td><label id="lblMoyenneEtudiant" runat="server"></label></td>
                    </tr>--%>
                    <%--<tr>
                        <td>Nombre d'etudiants</td>
                        <td><label id="lblNbrEtudiants" runat="server"></label></td>
                        <td>Observation</td>
                        <td><label id="lblobservation" runat="server"></label></td>
                    </tr>
                    <tr>
                        <td>Nombre Jour d'absance</td>
                        <td><label id="lblJourAbsance" runat="server"></label></td>
                        <td>Classement Par Group</td>
                        <td><label id="lblclassementParGroup" runat="server"></label></td>
                    </tr>--%>
                </table>
                <asp:SqlDataSource ID="DataListNotes" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="NotesEtudiant" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="Annee" Name="annee" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="semestre" Name="semestre" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="AnneesData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="AnneesEtudant" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </div>
            <br />
            <span id="emploi"></span>
            <h3>Mon Emploi de Temps</h3>
            <div class="BoiteEmploi">
                <p id="msgEmploi" runat="server" visible="false">Votre Emploi de Temps</p>
                <asp:GridView ID="ListEmploi" runat="server" CssClass="list" AutoGenerateColumns="False" DataSourceID="DataListEmploi" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Jour / Temps" HeaderText="Jour / Temps" SortExpression="Jour / Temps" />
                        <asp:BoundField DataField="8:30 - 9:30" HeaderText="8:30 - 9:30" SortExpression="8:30 - 9:30" />
                        <asp:BoundField DataField="9:30 - 10:30" HeaderText="9:30 - 10:30" SortExpression="9:30 - 10:30" />
                        <asp:BoundField DataField="10:30 - 11:30" HeaderText="10:30 - 11:30" SortExpression="10:30 - 11:30" />
                        <asp:BoundField DataField="11:30 - 12:30" HeaderText="11:30 - 12:30" SortExpression="11:30 - 12:30" />
                        <asp:BoundField DataField="14:30 - 15:30" HeaderText="14:30 - 15:30" SortExpression="14:30 - 15:30" />
                        <asp:BoundField DataField="15:30 - 16:30" HeaderText="15:30 - 16:30" SortExpression="15:30 - 16:30" />
                        <asp:BoundField DataField="16:30 - 17:30" HeaderText="16:30 - 17:30" SortExpression="16:30 - 17:30" />
                        <asp:BoundField DataField="17:30 - 18:30" HeaderText="17:30 - 18:30" SortExpression="17:30 - 18:30" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <asp:SqlDataSource ID="DataListEmploi" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Emploi" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
            <span id="exame"></span>
            <h3>Mes Exames</h3>
            <div class="Boitelist">
                <p id="VideExame" runat="server" visible="false">Aucun Exame n'est Valider Maintenant</p>
                <asp:GridView ID="ListExame" runat="server" AutoGenerateColumns="False" CssClass="list" GridLines="None" CellPadding="4" ForeColor="#333333" DataSourceID="DataListExame" AllowSorting="True">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Module" HeaderText="Module" SortExpression="Module" />
                        <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                        <asp:BoundField DataField="note" HeaderText="note" SortExpression="note" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <asp:SqlDataSource ID="DataListExame" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ExameEtudiant" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
            <span id="contactprof"></span>
            <h3>Mes Professeurs</h3>
            <div class="Boitelist">
                <table id="listMesProf" class="tblProf" runat="server">
                    <tr>
                        <th>Nom</th>
                        <th>Prenom</th>
                        <th>Gmail</th>
                    </tr>
                </table>
                <div id="contentListProf" runat="server"></div>
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
            document.getElementById("closeProfile").addEventListener("click", function () {
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
    </form>
</body>
</html>
