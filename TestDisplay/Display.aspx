<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Display.aspx.vb" Inherits="TestDisplay.Display" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <title>Diplay Records</title>
     
 
</head>
<body>
    <form id="form1" runat="server">
    <asp:GridView ID="grdDepartment" runat="server"  AutoGenerateColumns="false" AutoGenerateSelectButton="true" OnSelectedIndexChanged="GrdDepartment_SelectedIndexChanged">
    <Columns>
        <asp:BoundField DataField="Code" HeaderText="Code" ItemStyle-Width="100px" />
        <asp:BoundField DataField="Department" HeaderText="Department" ItemStyle-Width="200px" /> 
        
        <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:Button id="EditDept" runat="server" 
                            CommandName="approve" Text="Edit" />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
<br />
<asp:GridView ID="grdEmployees" runat="server" AutoGenerateColumns="false">
    <Columns>
        <asp:BoundField DataField="Code" HeaderText="Code" ItemStyle-Width="150px" />
        <asp:BoundField DataField="Names" HeaderText="Employee Name" ItemStyle-Width="250px" /> 
        
        <%--<asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:Button ID="Button2" runat="server" CausesValidation="false" CommandName="SendMail"
                    Text="Edit" CommandArgument='<%# Eval("id") %>' />
            </ItemTemplate>
        </asp:TemplateField>--%>

    </Columns>
</asp:GridView>
<br />
<br />
    <asp:Label ID="Code" runat="server" Text="Code"></asp:Label>
    <asp:TextBox ID="txtCode" runat="server" Text=""></asp:TextBox>
    <br />
      <asp:Label ID="Label1" runat="server" Text="Department"></asp:Label>
    <asp:TextBox ID="txtDepartment" runat="server" Text=""></asp:TextBox>
    <br />
  <%--  <asp:Button ID="btnSave"  runat="server" Text="Save"></asp:Button>--%>

    <asp:Button ID="btnSave" Text="Save" runat="server"/>
    </form>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/json2/0.1/json2.js"></script>
    <script type="text/javascript">
        function clear() {

            $("#txtCode").val("");

            $("#txtDepartment").val("");
             

        }
        $(function () {
            $('#btnSave').click(function () {

                var Code = $("#txtCode").val();
                var Department = $("#txtDepartment").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Display.aspx/saveData",
                    data: "{'Code':'" + Code + "','department':'" + Department + "'}",

                    dataType: "json",
                    success: function (data) {
                          $('#txtCode').val('');
                            $('#txtDepartment').val('');
                            alert("Department has been added successfully.");
                            window.location.reload();
                            }
                });
                return false;
            });
        });

         
    </script>


</body>
</html>
