<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentModule.aspx.cs" Inherits="Ecoule.ContentModule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style11 {
            width: 50%;
        }
        .auto-style12 {
            height: 20px;
            width: 130px;
        }
        .auto-style13 {
            width: 50%;
        }
        .divs {
            width:40%;
            float:left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <!--List Module-->
    <div class="divs">
        <br />
        <h3>Module</h3>
        <table class="auto-style4" id="tblModule" runat="server">
            <tr>
                <td class="auto-style13">Libelle</td>
                <td class="auto-style11">
                    <asp:TextBox ID="txtLibelleModule" runat="server" Width="100%" CssClass="mt-0"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="td_vide"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnAjoutModule" runat="server" CssClass="btnsOperation btnAjout" OnClick="btnAjoutModule_Click" Text="Ajout" />
                    <asp:Button ID="btnModifierModule" runat="server" CssClass="btnsOperation btnModifier" OnClick="btnModifierModule_Click" Text="Modifer" />
                    <asp:Button ID="btnSupprimerModule" CssClass="btnsOperation btnSupprimer" runat="server" OnClick="btnSupprimerModule_Click" Text="Supprimer" OnClientClick="return ConfirmDelete(this)" />
                    <asp:Button ID="btnIstialiser" CssClass="btnsOperation btnInsialiser" runat="server" OnClick="btnIstialiser_Click" Text="Intialiser" />
                </td>
            </tr>
            <tr>
                <td class="td_vide" colspan="2"><asp:Label ID="lblmsg" runat="server" Text=""></asp:Label></td>
            </tr>
        </table>
        <div>
            <asp:GridView ID="ListModule" runat="server" Width="90%" CssClass="list" AutoGenerateColumns="False" 
                OnSelectedIndexChanged="ListModule_SelectedIndexChanged"
                DataKeyNames="ID_MODULE" DataSourceID="ModuleData" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowSorting="True">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
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
            <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MODULE] order by ID_MODULE asc"></asp:SqlDataSource>
        </div>
    </div>
    <!--List Coefficiant par Module-->
    <div class="divs">
        <br />
        <h3>Coefficiant</h3>
        <table class="auto-style4" id="Table1" runat="server">
            <tr>
                <td class="auto-style13">Numero Section</td>
                <td class="auto-style11">
                    <asp:DropDownList ID="cmbSection" runat="server" Width="100%" CssClass="mt-0"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style13">ID Module</td>
                <td class="auto-style11">
                    <asp:DropDownList ID="cmbModule" runat="server" Width="100%" CssClass="mt-0"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style13">Coefficiant</td>
                <td class="auto-style11">
                    <asp:DropDownList ID="coeficiant" runat="server" Width="100%" CssClass="mt-0">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style12"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnAjoutCoef" runat="server" CssClass="btnsOperation btnAjout" OnClick="btnAjoutCoef_Click" Text="Ajout" />
                    <asp:Button ID="btnModifierCoef" runat="server" CssClass="btnsOperation btnModifier" OnClick="btnModifierCoef_Click" Text="Modifer" />
                    <asp:Button ID="btnSupprimerCoef" CssClass="btnsOperation btnSupprimer" runat="server" OnClick="btnSupprimerCoef_Click" Text="Supprimer" OnClientClick="return ConfirmDelete(this)" />
                    <asp:Button ID="btnIntialiserCoef" CssClass="btnsOperation btnInsialiser" runat="server" OnClick="btnIntialiserCoef_Click" Text="Intialiser" />
                </td>
            </tr>
            <tr>
                <td class="td_vide" colspan="2"><asp:Label ID="lblmsgC" runat="server" Text=""></asp:Label></td>
            </tr>
        </table>
        <div>
            <asp:GridView ID="listCoefficiant" runat="server" Width="100%" CssClass="list" AutoGenerateColumns="False" AllowSorting="True"
                OnSelectedIndexChanged="listCoefficiant_SelectedIndexChanged" DataSourceID="listCoefficiantData" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
                    <asp:BoundField DataField="NUMERO_SECTION" HeaderText="Section" ReadOnly="True" SortExpression="NUMERO_SECTION" />
                    <asp:BoundField DataField="LIBELLE" HeaderText="Module" SortExpression="LIBELLE" />
                    <asp:BoundField DataField="COEFFICIANT" HeaderText="Coefficiant" SortExpression="COEFFICIANT" />
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
            <asp:SqlDataSource ID="listCoefficiantData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT NUMERO_SECTION,LIBELLE,COEFFICIANT FROM [APPRENDRE] inner join MODULE on APPRENDRE.ID_MODULE=MODULE.ID_MODULE ORDER BY [NUMERO_SECTION]"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
