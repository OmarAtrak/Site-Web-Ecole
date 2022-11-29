<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageChangerMotPasse.aspx.cs" Inherits="Ecoule.PageChangerMotPasse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mot de Passe</title>
    <style>
        * {
            margin:0;
            padding:0;
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e2e5a7;
        }
        *:focus {
            outline: none;
        }
        #lblEmail {
            margin-left:20px;
            font-size:20px;
            color:darkblue;
        }
        #tbl_mot_passe {
            margin:20px;
            font-size:20px;
        }
        #tbl_mot_passe tr {
            height:40px;
        }
        #btnUpdateMotPasse {
            width:80%;
            height:30px;
            border-radius:5px 5px 5px 5px;
            border:none;
            background-color:silver;
        }
        .right {
            text-align: right;
        }
        .center {
            text-align:center;
        }
        #txtPassword, #txtPassword1, #txtPassword2 {
            height:25px;
            width:200px;
            border-radius: 5px;
            border: 2px solid silver;
            text-align: center;
            margin-left: 20px;
        }
        #txtPassword:active, #txtPassword1:active, #txtPassword2:active {
            border: 2px solid #18a4b2;
            outline:none
        }
        #txtPassword:focus, #txtPassword1:focus, #txtPassword2:focus {
            border: 2px solid #18a4b2;
            outline:none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="content_mot_passe" runat="server" class="content_mot_passe">
            <asp:Label ID="lblEmail" runat="server"></asp:Label>
            <table id="tbl_mot_passe" runat="server">
                <tr>
                    <td class="right"><label for="txtPassword">Vieux Mot de Passe:</label></td>
                    <td><asp:TextBox ID="txtPassword" runat="server" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="right"><label for="txtPassword1">Neuveau Mot de Passe:</label></td>
                    <td><asp:TextBox ID="txtPassword1" runat="server" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="right"><label for="txtPassword2">Configuration de Mot de Passe:</label></td>
                    <td><asp:TextBox ID="txtPassword2" runat="server" MaxLength="10"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2" id="msgErrorUpdate" runat="server" class="center" style="color:red"></td>
                </tr>
                <tr>
                    <td class="left"><asp:LinkButton ID="btnReteur" runat="server" Text="Reteur" OnClick="btnReteur_Click"></asp:LinkButton></td>
                    <td class="left"><asp:Button id="btnUpdateMotPasse" runat="server" OnClick="btnUpdateMotPasse_Click" Text="Mis à jour"/></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
