﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DBPOLLDemo.Controllers.AssignedAndUnassignedParticipants>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Modify Participant List
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Participant List for Session: <%= ViewData["sessionname"] %></h2>

    <h3>Participants in Session: <%=ViewData["sessionname"] %></h3>
    <table>
    <tr>
             <th class="style2">Remove Participant</th>
             <th class="style2">User ID</th>
             <th class="style2">Title</th>
             <th class="style2">Name</th>
             <th class="style2">Email</th>
             <th class="style2">Fax</th>
             <th class="style2">Phone</th>
             <th class="style2">Address</th>
             <th class="style2">City</th>
             <th class="style2">Post code</th>
             <th class="style2">State</th>
             <th class="style2">Country</th>
             <th class="style2">Department</th>
             <th class="style2">Company</th>
             <th class="style2">Weight</th>

        </tr>
        <% using (Html.BeginForm()) {  %>
        <% foreach (var par in Model.participants) { %>
        <tr>
         <td class="style2">
           <%= Html.ActionLink("Delete", "Delete", new { userid = par.userid, sessionid = ViewData["sessionid"], sessionname = ViewData["sessionname"] })%>
            </td>
            <td>
            <%= par.userid%>
            <input type="hidden" id="userid" name="userid" value="<%= par.userid%>" />
            </td>
            <td>
            <input type="text" name="titletxt" size="10" style="width:auto;" value="<%= par.title%>"/>
            </td>
            <td>
            <input type="text" name="nametxt" size="10" style="width:auto;" value="<%= par.name%>"/>
            </td>
            <td>
            <input type="text" name="emailtxt" size="10" style="width:auto;" value="<%= par.email%>"/>
            </td>
            <td>
            <input type="text" name="faxtxt" size="10" style="width:auto;" value="<%= par.fax%>"/>
            </td>
            <td>
            <input type="text" name="phonetxt" size="10" style="width:auto;" value="<%= par.phone%>"/>
            </td>
            <td>
            <input type="text" name="addresstxt" size="10" style="width:auto;" value="<%= par.address%>"/>
            </td>
            <td>
            <input type="text" name="citytxt" size="10" style="width:auto;" value="<%= par.city%>"/>
            </td>
            <td>
            <input type="text" name="postcodetxt" size="10" style="width:auto;" value="<%= par.postcode%>"/>
            </td>
            <td>
            <input type="text" name="statetxt" size="10" style="width:auto;" value="<%= par.state%>"/>
            </td>
            <td>
            <input type="text" name="countrytxt" size="10" style="width:auto;" value="<%= par.country%>"/>
            </td>
            <td>
            <input type="text" name="departmenttxt" size="10" style="width:auto;" value="<%= par.department%>"/>
            </td>
            <td>
            <input type="text" name="companytxt" size="10" style="width:auto;" value="<%= par.company%>"/>
            </td>
            <td>
            <input type="text" name="weight" size="10" style="width:auto;" value="<%= par.userweight%>"/>
            </td>
            </tr>
        <%}%>
            
        
        </table>

            <input type="hidden" id="session2" name="sessionid" value="<%=ViewData["sessionid"] %>" />
            <input type="hidden" id="sessionname2" name="sessionname" value="<%=ViewData["sessionname"] %>" />
            <input type="submit" id="submit2" name="submit" value="Save Changes" />

        <%} %>

    <h3>Participants Unassigned to Session: <%=ViewData["sessionname"] %></h3>

    <table>
    <tr>
             <th class="style2">Add Participant</th>
             <th class="style2">User ID</th>
             <th class="style2">User name</th>
             <th class="style2">Name</th>

        </tr>
        <% Html.BeginForm(); %>
        <% foreach (var par in Model.unassigned)
           { %>
        <tr>
         <td class="style2">
           <input type="checkbox" name="selectedObjects" value="<%= par.UserID%> "/>
            </td>
            <td>
            <%= par.UserID%>
            </td>
            <td>
            <%= par.username%>
            </td>
            <td>
            <%= par.Name%>
            </td>
            </tr>
        <%}%>
        </table>

        <input type="hidden" id="sessionid" name="sessionid" value="<%=ViewData["sessionid"] %>" />
        <input type="hidden" id="sessionname" name="sessionname" value="<%=ViewData["sessionname"] %>" />
        <input type="submit" id="submit" name="submit" value="Add Participants" />
        <% Html.EndForm(); %>

        <p>
        <%= Html.ActionLink("Back to Polls", "../Poll/Index")%>
    </p>

</asp:Content>
