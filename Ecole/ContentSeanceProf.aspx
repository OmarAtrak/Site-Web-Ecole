<%@ Page Title="" Language="C#" MasterPageFile="~/PageProfesseur.Master" AutoEventWireup="true" CodeBehind="ContentSeanceProf.aspx.cs" Inherits="Ecoule.ContentSeanceProf" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .BoxlistSeance {
            width:70%;
            height:425px;
            margin-left:10px;
            box-sizing:border-box;
            float:right;
            overflow-y:auto;
        }
        #ListSeance {
            width:100%;
        }
        #ListSeance th {
            font-size:18px;
            font-weight:500;
            width:1000px;
        }
        .td_vide {
            height:20px;
        }
        .btnsOperation {
            margin:10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Seance</h3>
    <div class="content_Seance">
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
                <td class="left"><asp:TextBox ID="txtModule" runat="server" Enabled="false" Width="100%"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="left"><label for="Date">Date</label></td>
                <td class="left"><asp:TextBox ID="txtDate" runat="server" AutoPostBack="true" TextMode="Date" Width="100%"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="left" style="width:300px;"><label for="cmbHeureDebut">Heure Debut</label></td>
                <td class="left">
                    <asp:DropDownList ID="cmbHeureDebut" runat="server" AutoPostBack="true"  Width="100%" OnSelectedIndexChanged="cmbHeureDebut_SelectedIndexChanged">
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
                    <asp:DropDownList ID="cmbHeureFin" runat="server" AutoPostBack="true" Width="100%">
                        <asp:ListItem>09:30</asp:ListItem>                        
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="left"><label for="cmbSalle">Salle</label></td>
                <td class="left"><asp:DropDownList ID="cmbSalle" runat="server" Width="100%" ItemType="int"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2" class="td_vide">
                    <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button id="btnValiderSeance" CssClass="btnsOperation btnAjout" runat="server" Text="Ajouter" OnClick="btnValiderSeance_Click"/>
                    <!--<asp:Button id="btnModifier" CssClass="btnsOperation btnModifier" runat="server" Text="Modifier" OnClick="btnModifier_Click"/>-->
                    <asp:Button id="btnSupprimer" CssClass="btnsOperation btnSupprimer" runat="server" Text="Supprimer" OnClick="btnSupprimer_Click" OnClientClick="return confirm('Voullez-Vous Supprimer la Séance?');"/>
                    <asp:Button id="btnInitialiser" CssClass="btnsOperation btnInsialiser" runat="server" Text="Intialiser" OnClick="btnInitialiser_Click"/>

                </td>
            </tr>
        </table>
        <div class="BoxlistSeance">
            <asp:GridView ID="ListSeance" runat="server" 
                OnSelectedIndexChanged="ListSeance_SelectedIndexChanged" CellPadding="3"
                GridLines="Vertical" AllowSorting="True" AutoGenerateColumns="False" 
                DataSourceID="SeanceData" CssClass="list auto-style1" BackColor="White" BorderColor="#999999" 
                BorderStyle="None" BorderWidth="1px">
            <AlternatingRowStyle BackColor="#DCDCDC" />
                <Columns>
                    <asp:BoundField DataField="Seance" headerText="Seance" SortExpression="Seance" />
                    <asp:BoundField DataField="Module" HeaderText="Module" SortExpression="Module" />
                    <asp:BoundField DataField="Group" HeaderText="Group" ReadOnly="True" SortExpression="Group" />
                    <asp:BoundField DataField="Salle" HeaderText="Salle" SortExpression="Salle" />
                    <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                    <asp:BoundField DataField="Heure Début" HeaderText="Heure Début" ReadOnly="True" SortExpression="Heure Début" />
                    <asp:BoundField DataField="Heure Fin" HeaderText="Heure Fin" ReadOnly="True" SortExpression="Heure Fin" />
                    <asp:ButtonField CommandName="Select" Text="Selectionner" />
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
        <asp:SqlDataSource ID="ModuleData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="ModuleProf" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>    
    </div>

    <script>
        //var object = { status: false, ele: null };
        //function Confirmer() {
        //    if (object.status) { return true; };
        //    confirm("Veullez-vous Supprimer la Seance");
        //    function () {
        //        object.status = true;
        //        object.ele = ev;
        //        object.ele.click();
        //    });
        //    return false;
        //}

        var object = { status: false, ele: null };

        function ConfirmDelete(ev) {
            if (object.status) { return true; };
            confirm("Veullez-vous Supprimer la Seance");
            function () {
                object.status = true;
                object.ele = ev;
                object.ele.click();
            }
            return false;
        }


        // sweet alert for delete
        //var object = { status: false, ele: null };

        //function ConfirmDelete(ev) {
        //    if (object.status) { return true; };
        //    swal({
        //        title: "Vous-etes sur?",
        //        text: "Vous Voullez Supprimer",
        //        type: "warning",
        //        showCancelButton: true,
        //        confirmButtonClass: "btn-danger",
        //        confirmButtonText: "Oui, Supprimer!",
        //        closeOnConfirm: true
        //    },
        //        function () {
        //            object.status = true;
        //            object.ele = ev;
        //            object.ele.click();
        //        });
        //    return false;
        //}
    </script>
</asp:Content>
