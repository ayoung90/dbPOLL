<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<DBPOLLDemo.Models.answerModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Answers for : <%= Html.Encode(ViewData["name"]) %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Answers for : <%= Html.Encode(ViewData["name"]) %></h2>

    <table>
        <tr>
            <th>Actions</th>
            <th>Answer Number</th>
            <th>Answer</th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td><%= Html.ActionLink("Delete", "Delete", new { answerid = item.AnswerID, id = ViewData["id"], name = ViewData["name"] })%> |
                <%= Html.ActionLink("Edit", "Edit", new { questionid = ViewData["id"] })%> |
                <%= Html.ActionLink("Details", "Details", new { /* id=item.PrimaryKey */ })%>
            
            </td>
            <td>
                <%= Html.Encode(String.Format("{0}", item.AnswerNumber)) %>
            </td>
            <td>
                <%= Html.Encode(item.Answer) %>
            </td>
            
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Create New", "Create", new { questionid = ViewData["id"], name = ViewData["name"] })%>
    </p>

</asp:Content>

