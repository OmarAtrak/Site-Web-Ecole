<%@ Page Title="" Language="C#" MasterPageFile="~/PageAdmin.Master" AutoEventWireup="true" CodeBehind="ContentSeance.aspx.cs" Inherits="Ecoule.ContentSeance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .listSeance {
            margin:auto;
        }
        th,td {
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageAdmin" runat="server">
    <br />
    <h3>Seance</h3>
    <div>
        <br />
            <table class="tbl_ValideSeance">
                <tr>
                    <td class="left"><label for="cmbGroup">Group</label></td>
                    <td class="left"><asp:DropDownList ID="cmbGroup" runat="server" AutoPostBack="True" Width="186px" DataSourceID="GroupData" DataTextField="Group" DataValueField="Group"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td class="left"><label for="Date">Date</label></td>
                    <td class="left"><asp:TextBox ID="txtDate" runat="server" AutoPostBack="true" TextMode="Date" Width="186px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="left"><label for="cmbHeureDebut">Heure Debut</label></td>
                    <td class="left">
                        <asp:DropDownList ID="cmbHeureDebut" runat="server" AutoPostBack="true"  Width="186px" OnSelectedIndexChanged="cmbHeureDebut_SelectedIndexChanged">
                        <asp:ListItem>08:30</asp:ListItem>
                        <asp:ListItem>09:30</asp:ListItem>
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
                        <asp:DropDownList ID="cmbHeureFin" runat="server" AutoPostBack="true" Width="186px">
                            <asp:ListItem>09:30</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                    <td class="left"><label for="cmbSalle">Salle</label></td>
                    <td class="left"><asp:DropDownList ID="cmbSalle" runat="server" Width="186px" ItemType="int"></asp:DropDownList></td>
                    </tr>
                <tr>
                    <td class="left"><label for="cmbProf">Professeur</label></td>
                    <td class="left"><asp:DropDownList ID="cmbProf" runat="server" Width="186px" DataSourceID="ProfData" DataTextField="MATRICULE" DataValueField="MATRICULE"></asp:DropDownList></td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <asp:Button id="btnValiderSeance" runat="server" CssClass="btnsOperation btnAjout" Text="Ajouter" OnClick="btnValiderSeance_Click"/>
                        <!--<asp:Button id="btnModifier" runat="server" CssClass="btnsOperation btnModifier" Text="Modifier" OnClick="btnModifier_Click"/>-->
                        <asp:Button id="btnSupprimer" runat="server" CssClass="btnsOperation btnSupprimer" Text="Supprimer" OnClick="btnSupprimer_Click" OnClientClick="return ConfirmDelete(this);"/>
                        <asp:Button id="btnIntialiser" runat="server" CssClass="btnsOperation btnInsialiser" Text="Initialiser" OnClick="btnIntialiser_Click"/>
                    </td>
                </tr>
                <tr>
                    <td class="td_vide left" colspan="2"><asp:Label ID="msg" runat="server" Text=""></asp:Label></td>
                </tr>
            </table>
            <div class="BoxlistSeance">
            <br />
            <asp:GridView ID="ListSeance" runat="server" OnSelectedIndexChanged="ListSeance_SelectedIndexChanged" 
                CellPadding="3" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SeanceData" 
                CssClass="listSeance" Width="90%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                    <Columns>
                        <asp:ButtonField CommandName="Select" Text="Selectionner" />
                        <asp:BoundField DataField="Seance" HeaderText="Seance" SortExpression="Seance" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="Group" HeaderText="Group" ReadOnly="True" SortExpression="Group" />
                        <asp:BoundField DataField="Module" HeaderText="Module" SortExpression="Module" />
                        <asp:BoundField DataField="Professeur" HeaderText="Professeur" SortExpression="Professeur" />
                        <asp:BoundField DataField="Salle" HeaderText="Salle" SortExpression="Salle" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" ReadOnly="True" />
                        <asp:BoundField DataField="Heure Debut" HeaderText="Heure Debut" SortExpression="Heure Debut" ReadOnly="True" />
                        <asp:BoundField DataField="Heure fin" HeaderText="Heure fin" SortExpression="Heure fin" ReadOnly="True" />
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
            </div>
            <asp:SqlDataSource ID="SeanceData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT SEANCE.ID_SEANCE AS Seance, CONVERT (varchar, [GROUP].NUMERO_SECTION) + 'AC' + CONVERT (varchar, [GROUP].NUMERO_GROUP) AS [Group], MODULE.LIBELLE as Module,PROFESSEUR as Professeur ,DETAIL_SEANCE.NUMERO_SALLE AS Salle,
                            right(SEANCE.DATE_SEANCE,10) AS Date, left(SEANCE.HEURE_DEBUT,5) AS [Heure Debut], left(SEANCE.HEURE_FIN,5) AS [Heure fin] FROM SEANCE 
INNER JOIN DETAIL_SEANCE ON SEANCE.ID_SEANCE = DETAIL_SEANCE.ID_SEANCE 
inner join PROFESSEUR on DETAIL_SEANCE.PROFESSEUR=PROFESSEUR.MATRICULE
INNER JOIN MODULE ON PROFESSEUR.ID_MODULE = MODULE.ID_MODULE INNER JOIN [GROUP] ON DETAIL_SEANCE.ID_GROUP = [GROUP].ID_GROUP order by DATE_SEANCE desc">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SalleDisponibleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [NUMERO_SALLE] FROM [SALLE]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="GroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select CONVERT (varchar, [GROUP].NUMERO_SECTION) + 'AC' + CONVERT (varchar, [GROUP].NUMERO_GROUP) AS [Group] from [GROUP]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [LIBELLE] FROM [MODULE]">
            </asp:SqlDataSource>
                <asp:SqlDataSource ID="ProfData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [MATRICULE] FROM [PROFESSEUR]"></asp:SqlDataSource>
            
    </div>
</asp:Content>
