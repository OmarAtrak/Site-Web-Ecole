<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentSalle.aspx.cs" Inherits="Ecoule.ContentSalle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <div>
        <br />
        <span id="salle"></span>
        <h3>Salle</h3>
        <div>
            <table class="auto-style4" id="tblSalle" runat="server">
                <tr>
                    <td class="auto-style13">Numero</td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtNumero" runat="server" Width="186px" CssClass="mt-0" TextMode="Number"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style13">Utilitation</td>
                    <td class="auto-style11">
                        <asp:TextBox ID="txtUtilisationSalle" runat="server" Width="186px" CssClass="mt-0"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnAjoutSalle" runat="server" CssClass="btnsOperation btnAjout" OnClick="btnAjoutSalle_Click" Text="Ajout" />
                        <asp:Button ID="btnModifierSalle" runat="server" CssClass="btnsOperation btnModifier" OnClick="btnModifierSalle_Click" Text="Modifer" />
                        <asp:Button ID="btnSupprimerSalle" CssClass="btnsOperation btnSupprimer" runat="server" OnClick="btnSupprimerSalle_Click" Text="Supprimer" OnClientClick="return ConfirmDelete(this)" />
                        <asp:Button ID="btnIstialiser" CssClass="btnsOperation btnInsialiser" runat="server" OnClick="btnIstialiser_Click" Text="Intialiser" />
                    </td>
                </tr>
                <tr>
                    <td class="td_vide" colspan="2"><asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label></td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="ListSalle" runat="server" Width="90%" CssClass="list"
                AutoGenerateColumns="False" BorderColor="#CCCCCC" BorderStyle="None" 
                BorderWidth="1px" CellPadding="3" DataKeyNames="NUMERO_SALLE" 
                AllowSorting="True" BackColor="White" OnSelectedIndexChanged="ListSalle_SelectedIndexChanged">
                <Columns>
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
                    <asp:BoundField DataField="NUMERO_SALLE" HeaderText="Numero" ReadOnly="True" SortExpression="NUMERO_SALLE" />
                    <asp:BoundField DataField="UTILISATION" HeaderText="Utilisation" SortExpression="UTILISATION" />
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
</asp:Content>
