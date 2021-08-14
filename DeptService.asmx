<%@ WebService Language="VB" Class="WebService1" %>

Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Xml.Serialization
Imports System.Data.SqlClient

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace := "http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _  
Public Class WebService1
    Inherits System.Web.Services.WebService 

    ' WEB SERVICE EXAMPLE
    ' The HelloWorld() example service returns the string Hello World.
    '
    <WebMethod()> _
    Public Shared Function saveData(ByVal Code As String, ByVal department As String) As Integer
        Try
            Dim status As Integer = 1
            Dim Query As String = String.Empty
            Dim cn As SqlConnection = New SqlConnection("Data Source=.; Initial Catalog=Json;Integrated Security=True;User Id=sa;Password=asd123@;")
            Query = "INSERT INTO Student (Code,Department) VALUES ('" & Code & "','" & department & "')"
            Dim cmd As SqlCommand = New SqlCommand(Query, cn)
            cn.Open()
            cmd.ExecuteNonQuery()
            cn.Close()
            Return status
             
        Catch
            Return -1
        End Try
    End Function

End Class
