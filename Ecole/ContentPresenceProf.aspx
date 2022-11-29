<%@ Page Title="" Language="C#" MasterPageFile="~/PageProfesseur.Master" AutoEventWireup="true" CodeBehind="ContentPresenceProf.aspx.cs" Inherits="Ecoule.ContentPresenceProf" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #infoNote {
            width:35%;
            margin-top:30px;
            margin-right:5px;
            margin-left:20px;
            float:left;
        }
        #infoNote table{
            border:silver 1px solid;
            width:100%;
        }
        #listNote {
            width:60%;
            margin-bottom:50px;
            float:right;
        }
        #listNote h3 {
            margin-top:130px;
            display:inline-block;
            margin-bottom:0px;
        }
        .listSeance {
            height:250px;
            margin-bottom:10px;
            overflow:auto;
        }
        .btn_pdf1 {
            margin-left: 87%;
            margin-bottom: -52px;
        }
        .lbl_choix1 {
            margin-left:10%;
            margin-right:15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sm" runat="server">
    </asp:ScriptManager>
    <div class="content_participer_seance">
                <div id="infoNote">
                    <asp:UpdatePanel ID="up" runat="server">
                    <ContentTemplate>
                    <h3>List de Seance</h3>
                    <div class="listSeance">
                        <asp:GridView ID="listSeance" runat="server" CssClass="list" Width="100%"
                            AutoGenerateColumns="False"
                            OnSelectedIndexChanged="listSeance_SelectedIndexChanged"
                            CellPadding="3" GridLines="Vertical" AllowSorting="True" BackColor="White" 
                            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSorting="listSeance_Sorting" >
                            <Columns>
                                <asp:BoundField DataField="Seance" HeaderText="Seance" SortExpression="Seance" />
                                <asp:BoundField DataField="Group" HeaderText="Group" ReadOnly="True" SortExpression="Group" />
                                <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
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
                        <asp:SqlDataSource ID="SeanceData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select DETAIL_SEANCE.ID_SEANCE as Seance,convert(varchar,[GROUP].NUMERO_SECTION)+'AC'+convert(varchar,[GROUP].NUMERO_GROUP) as [Group],left(DATE_SEANCE,10) as [Date] from [GROUP] inner join DETAIL_SEANCE on [GROUP].ID_GROUP=DETAIL_SEANCE.ID_GROUP inner join SEANCE on DETAIL_SEANCE.ID_SEANCE=SEANCE.ID_SEANCE inner join PROFESSEUR on DETAIL_SEANCE.PROFESSEUR=PROFESSEUR.MATRICULE where PROFESSEUR.MATRICULE=@num order by DATE_SEANCE desc">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                    <table>
                        <tr>
                            <td>Etudiant</td>
                            <td><asp:TextBox ID="NumEtdParticiper" runat="server" Enabled="false" ></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Seane</td>
                            <td><asp:TextBox ID="NumSeanceParticiper" runat="server" Enabled="false" ></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Present</td>
                            <td class="left"><asp:CheckBox ID="Present" runat="server" AutoPostBack="true" OnCheckedChanged="Present_CheckedChanged" TextAlign="Right"/></td>
                        </tr>
                        <tr>
                            <td colspan="2"><asp:Label ID="msg" runat="server" Text=""></asp:Label></t>
                        </tr>
                    </table>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="listNote">
                    <h3>List de Presence</h3>
                    <asp:Label ID="lblGroupParticiper" CssClass="lbl_choix1" runat="server">Group</asp:Label><asp:TextBox ID="txtGroup" runat="server" Width="15%" Enabled="false"></asp:TextBox>
                    <asp:Label ID="seance2" CssClass="lbl_choix1" runat="server">Seance</asp:Label><asp:TextBox ID="txtSeance" runat="server" Width="15%" Enabled="false"></asp:TextBox>
                    
                    <div id="content_participer_seance" runat="server">
                        <asp:ImageButton ID="btnTelechargerPdf" runat="server" OnClick="btnTelechargerPdf_Click" CssClass="btn_pdf1" ToolTip="Telecharger Sous Format PDF" ImageUrl="~/icons/icons8-pdf-file-format-53.png" Width="22px" />
                        <asp:UpdatePanel ID="up2" runat="server">
                        <ContentTemplate>
                        <asp:GridView ID="ListParticipation" runat="server" CssClass="list" Width="90%"
                            AutoGenerateColumns="False"
                            OnSelectedIndexChanged="ListParticipation_SelectedIndexChanged"
                            CellPadding="3" GridLines="Vertical" AllowSorting="True" BackColor="White" 
                            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" DataSourceID="ListParticipationData" >
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" />
                            <asp:BoundField DataField="Nom" HeaderText="Nom" SortExpression="Nom" />
                            <asp:BoundField DataField="Prenom" HeaderText="Prenom" SortExpression="Prenom" />
                            <asp:BoundField DataField="Presence" HeaderText="Presence" SortExpression="Presence" />
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
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    </div>
                    <!--<asp:Button ID="btnAjoutParticipant" CssClass="btnPresedent" runat="server" Text="Ajout" Visible="false"/>
                    <asp:Button ID="btnPresedentPS" CssClass="btnPresedent" runat="server" Text="Presedent" Visible="false"/>
                    <p id="deplacementEtdP" runat="server" Visible="false"><span id="indexNumEtdPS" runat="server">0</span>/<span id="nbrEtdparGroup" runat="server"></span></p>
                    <asp:Button ID="btnSuivantPS" CssClass="btnSuivant" runat="server" Text="Suivant" Visible="false" />
                    <asp:Button ID="btnModifierParticipant" CssClass="btnSuivant" runat="server" Text="Modifer" Visible="false" />-->
                    <asp:SqlDataSource ID="ListParticipationData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="PresenceParticiper" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtGroup" Name="group" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="txtSeance" Name="seance" PropertyName="Text" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <%--<asp:SqlDataSource ID="SeanceGroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SeanceGroup" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cmbGroupSeance" Name="group" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>--%>
                    <asp:SqlDataSource ID="GroupData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select top(1) CONVERT(varchar,NUMERO_SECTION)+'AC'+CONVERT(varchar,NUMERO_GROUP) as ID_GROUP from [GROUP] 
		                inner join DETAIL_SEANCE on DETAIL_SEANCE.ID_GROUP=[GROUP].ID_GROUP
		                inner join SEANCE on DETAIL_SEANCE.ID_SEANCE=SEANCE.ID_SEANCE
		                where PROFESSEUR=@num
		                order by DATE_SEANCE desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblNumero" Name="num" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" CssClass="list" Width="90%"
                            AutoGenerateColumns="False" Visible="false"
                            CellPadding="3" GridLines="Vertical" AllowSorting="True" BackColor="White" 
                            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" DataSourceID="SqlDataSource1" >
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Column1" HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                            <asp:BoundField DataField="Column2" HeaderText="Column2" ReadOnly="True" SortExpression="Column2" />
                            <asp:BoundField DataField="Column3" HeaderText="Column3" ReadOnly="True" SortExpression="Column3" />
                            <asp:BoundField DataField="Column4" HeaderText="Column4" ReadOnly="True" SortExpression="Column4" />
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
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select 'Numero','Nom','Prenom','Presence'"></asp:SqlDataSource>
                    <asp:GridView ID="listGroup" runat="server" CssClass="list" Width="90%"
                            AutoGenerateColumns="False" Visible="false"
                            OnSelectedIndexChanged="ListParticipation_SelectedIndexChanged"
                            CellPadding="3" GridLines="Vertical" AllowSorting="True" BackColor="White" 
                            BorderColor="#999999" BorderStyle="None" BorderWidth="1px" DataSourceID="ListParticipationData" >
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Numero" HeaderText="Numero" SortExpression="Numero" />
                            <asp:BoundField DataField="Nom" HeaderText="Nom" SortExpression="Nom" />
                            <asp:BoundField DataField="Prenom" HeaderText="Prenom" SortExpression="Prenom" />
                            <asp:BoundField DataField="Presence" HeaderText="Presence" SortExpression="Presence" />
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
</div>
</asp:Content>
