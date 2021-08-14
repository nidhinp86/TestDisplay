Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services
Public Class Display
    Inherits System.Web.UI.Page
     
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Show()
        End If
    End Sub

    Public Sub Show()
        Dim constr As String = ConfigurationManager.ConnectionStrings("DataConnection").ConnectionString
        Dim query As String = "SELECT Code, Department FROM tblDepartment;"
        query += "SELECT Code, Names FROM tblName"

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand(query)
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    Using ds As New DataSet()
                        sda.Fill(ds)
                        grdDepartment.DataSource = ds.Tables(0)
                        grdDepartment.DataBind()
                        grdEmployees.DataSource = ds.Tables(1)
                        grdEmployees.DataBind()
                    End Using
                End Using
            End Using
        End Using
    End Sub

    Sub grdDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

        Dim row As GridViewRow = grdDepartment.SelectedRow

        txtCode.Text = row.Cells(1).Text
        txtDepartment.Text = row.Cells(2).Text
    End Sub

    <WebMethod()> _
    Public Shared Function saveData(ByVal Code As String, ByVal department As String) As Integer
        Try
            Dim status As Integer = 1
            Dim Query As String = String.Empty
            Dim cn As SqlConnection = New SqlConnection("Data Source=.; Initial Catalog=Test;Integrated Security=True;User Id=sa;Password=asd123@;")
            Using cmd As New SqlCommand("insert into sampleinfo(Code,Department) VALUES(@Code,@Department)", cn)

                cn.Open()
                cmd.Parameters.AddWithValue("@Code", Code)
                cmd.Parameters.AddWithValue("@Department", department) 

                cmd.ExecuteNonQuery()
                cn.Close()
                Return status
            End Using
        Catch
            Return -1
        End Try
    End Function
End Class