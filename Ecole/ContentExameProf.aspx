<%@ Page Title="" Language="C#" MasterPageFile="~/PageProfesseur.Master" AutoEventWireup="true" CodeBehind="ContentExameProf.aspx.cs" Inherits="Ecoule.ContentExameProf" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .valdierExame {
            width:35%;
            margin-right:30px;
            margin-left:30px;
            float:left;
        }
        .Content_Notes{
            width:60%;
            float:left;
        }
        .valdierExame > div > table {
            margin:auto;
            border:1px gray solid;
            height:100px;
        }
        .valdierExame > table > tr > td {
            border-bottom:none;
            height:100px;
        }
        .lbl_choix1 {
            margin-left:20px;
            margin-right:20px;
        }
        #ListExame {
            margin:auto;
        }
        .BoxListExame {
            height:330px;
            overflow-y:auto
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sm" runat="server">
    </asp:ScriptManager>
    <%--<asp:UpdatePanel ID="up" runat="server">
        <ContentTemplate>--%>
            <h3>Exame</h3>
            <div class="content_exame valdierExame">
                <div>
                    <!--<asp:Label ID="lblNumeroExame" runat="server">Numero Exame</asp:Label>
                    <asp:TextBox ID="txtNumeroExame" runat="server" TextMode="Number" CssClass="cmb_choix"></asp:TextBox>-->
                    <table>
                        <tr>
                            <td class="left" colspan="2">Valider Exame</td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblIDModule" runat="server">Module</asp:Label></td>
                            <td><asp:TextBox ID="txtModule" runat="server" Width="70%" Enabled="false"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblDate" runat="server">Date Exame</asp:Label></td>
                            <td><asp:TextBox ID="txtDateExame" runat="server" TextMode="Date" CssClass="cmb_choix" Width="70%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnAjouterExame" runat="server" Text="Valider" CssClass="btnsOperation btnAjout" OnClick="btnAjouterExame_Click"/>
                                <asp:Button ID="btnModifierExame" runat="server" Text="Modifier" CssClass="btnsOperation btnModifier" OnClick="btnModifierExame_Click"/>
                                <asp:Button ID="btnSupprimerExame" runat="server" Text="Supprimer" CssClass="btnsOperation btnSupprimer" OnClick="btnSupprimerExame_Click"/>
                                <asp:Button ID="btnInitialiser" runat="server" Text="Initialiser" CssClass="btnsOperation btnInsialiser" OnClick="btnInitialiser_Click"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <div class="BoxListExame">
                    <asp:GridView ID="ListExame" runat="server" AutoGenerateColumns="False" CssClass="list"
                        BackColor="White" BorderColor="#999999" BorderStyle="None" 
                        OnSelectedIndexChanged="ListExame_SelectedIndexChanged"
                        BorderWidth="1px" CellPadding="3" DataKeyNames="ID_EXAME" DataSourceID="ListExameData" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:ButtonField CommandName="Select" Text="Selectionner" />
                            <asp:BoundField DataField="ID_EXAME" HeaderText="ID" ReadOnly="True" SortExpression="ID_EXAME" />
                            <asp:BoundField DataField="LIBELLE" HeaderText="Module" SortExpression="LIBELLE" />
                            <asp:BoundField DataField="DATE_EXAME" HeaderText="Date" SortExpression="DATE_EXAME" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle ForeColor="Black" BackColor="#EEEEEE" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#0000A9" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#000065" />
                    </asp:GridView>
                </div>
                <asp:SqlDataSource ID="ListExameData" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT ID_EXAME,LIBELLE,left(DATE_EXAME,10) as DATE_EXAME FROM EXAME inner join MODULE on EXAME.ID_MODULE=MODULE.ID_MODULE inner join PROFESSEUR on MODULE.ID_MODULE=PROFESSEUR.ID_MODULE where MATRICULE=@MATRICULE">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="MATRICULE" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="Content_Notes">
                <table><tr><td>Notes Exame</td></tr></table>
                <br />
                <asp:Label ID="lblGroup2" CssClass="lbl_choix1" runat="server">Group</asp:Label><asp:DropDownList ID="cmbExameGroup" runat="server" OnSelectedIndexChanged="cmbExameGroup_SelectedIndexChanged" CssClass="cmb_choix" Width="20%" AutoPostBack="True" DataSourceID="GroupData" DataTextField="ID_GROUP" DataValueField="ID_GROUP"></asp:DropDownList>
                <asp:Label ID="lblExame" CssClass="lbl_choix" runat="server">Exame</asp:Label><asp:DropDownList ID="cmbExame" runat="server" OnSelectedIndexChanged="cmbExame_SelectedIndexChanged" CssClass="cmb_choix" Width="20%" DataSourceID="ExameData" DataTextField="ID_EXAME" AutoPostBack="true" DataValueField="ID_EXAME"></asp:DropDownList>
                <asp:GridView ID="ListNotesExame" runat="server" 
                    OnSelectedIndexChanged="ListNotesExame_SelectedIndexChanged"
                    CssClass="list" Width="100%" AutoGenerateColumns="False" CellPadding="3" GridLines="Vertical" DataSourceID="ListNotesExameData" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:ButtonField CommandName="Select" Text="Selectionner" />
                        <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" />
                        <asp:BoundField DataField="Nom" HeaderText="Nom" SortExpression="Nom" />
                        <asp:BoundField DataField="Prenom" HeaderText="Prenom" SortExpression="Prenom" />
                        <asp:BoundField DataField="Note" HeaderText="Note" SortExpression="Note" />
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
                <asp:SqlDataSource ID="ExameData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ExameProf" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="GroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="GroupProf" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                <asp:SqlDataSource ID="ListNotesExameData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ListNoteGroup" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cmbExameGroup" Name="group" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="cmbExame" Name="exame" PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ModuleProf" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                <br />
                <label id="lblNumEtd" runat="server" class="lbl_choix2" for="txtNumeroEtd">Numero Etudiant</label><asp:TextBox ID="txtNumeroEtd" runat="server" Enabled="False"></asp:TextBox>
                <label class="lbl_choix2" for="txtExame">Numero Exame</label><asp:TextBox ID="txtExame" runat="server" Enabled="False"></asp:TextBox>
                <label class="lbl_choix2" for="txtNote">Note</label><asp:TextBox ID="txtNote" runat="server"></asp:TextBox>
                <asp:Button ID="btnValiderNote" CssClass="btnsOperation btnAjout" runat="server" Text="Ajout" OnClick="btnValiderNote_Click"/>
                <asp:Button ID="btnModiferNote" CssClass="btnsOperation btnModifier" runat="server" Text="Modifer" OnClick="btnModiferNote_Click"/>
                <br />
            </div>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
