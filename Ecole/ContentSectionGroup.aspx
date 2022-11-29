<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentSectionGroup.aspx.cs" Inherits="Ecoule.ContentSectionGroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        .auto-style9 {
            width: 80%;
            margin-left:0;
        }
        .divS {
            margin-left:20px;
            margin-right:20px;
            float:left;
            width:40%;
        }
        .divS table {
            width:100%;
        }
        .auto-style10 {
            margin-left: 0px;
        }
        .auto-style11 {
            float: left;
            margin-right: 100px;
            height: 450px;
            width: 20%;
        }
        .auto-style13 {
            width: 114px;
        }
        .content {
            width:50%;
            float:left;
        }
        .ListFloat {
            float:left;
            margin-left:0px;
            width:100%;
            margin-bottom:40px;
        }
        .div2 {
            margin-left: 20px;
            margin-right: 20px;
            float: left;
            width: 55%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <asp:ScriptManager ID="sm" runat="server">
        <Scripts>
        </Scripts>
    </asp:ScriptManager>
    <%--<asp:UpdatePanel ID="up" runat="server">
        <ContentTemplate>--%>
            <!--List Section-->
            <div class="auto-style11 divS">
                <br />
                <span id="section"></span>
                <h3>Section</h3>
                <div class="content">
                    <table id="tblSection" runat="server" class="auto-style9">
                        <tr>
                            <td class="auto-style1">Section</td>
                            <td class="auto-style13">
                                <asp:TextBox ID="txtNumeroSection" runat="server" Width="130px" Enabled="false" CssClass="auto-style10"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnAjoutSection" CssClass="btnsOperation btnAjout" runat="server" Text="Ajout" Width="50%" OnClick="btnAjoutSection_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:GridView ID="ListSection" runat="server" CssClass="list" AllowSorting="true"
                        AutoGenerateColumns="False" AutoGenerateSelectButton="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnSorting="ListSection_Sorting">
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
                    <br />
                </div>
            </div>
            <!--List Group-->
            <div class="div2">
        <br />
        <h3>Group</h3>
        <div>
            <table id="tblGroup" runat="server" class="ListFloat">
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
                        <asp:Button ID="btnAjoutGroup" runat="server" OnClick="btnAjoutGroup_Click" CssClass="btnsOperation btnAjout" Text="Ajout" />
                        <asp:Button ID="btnModifierGroup" runat="server" OnClick="btnModifierGroup_Click" CssClass="btnsOperation btnModifier" Text="Modifer" />
                        <asp:Button ID="btnSupprimerGroup" runat="server" OnClick="btnSupprimerGroup_Click" CssClass="btnsOperation btnSupprimer" Text="Supprimer" OnClientClick="return ConfirmDelete(this);" />
                        <asp:Button ID="bntIntialiser" runat="server" OnClick="bntIntialiser_Click" CssClass="btnsOperation btnInsialiser" Text="Initialiser" />
                    </td>
                </tr>
                <tr>
                    <td class="td_vide" colspan="2"><asp:Label ID="lblmsg" runat="server" Text=""></asp:Label></td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="ListGroup" runat="server" CssClass="list" AllowSorting="True"
                AutoGenerateColumns="False" OnSelectedIndexChanged="ListGroup_SelectedIndexChanged"
                DataKeyNames="ID_GROUP" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" OnSorting="ListGroup_Sorting">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
                    <asp:BoundField DataField="ID_GROUP" HeaderText="ID" ReadOnly="True" SortExpression="ID_GROUP" />
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
            <span id="finGroup" runat="server"></span>
            <asp:SqlDataSource ID="SectionGroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [NUMERO_SECTION] FROM [SECTION]"></asp:SqlDataSource>
        </div>
    </div>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
