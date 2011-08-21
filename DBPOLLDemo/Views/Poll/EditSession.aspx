﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<DBPOLLDemo.Models.SESSION>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	EditSession
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
  html { height: 100% }
  body { height: 100%; margin: 0; padding: 0 }
  #map_canvas { height: 100% }
</style>
<script type="text/javascript"
    src="http://maps.googleapis.com/maps/api/js?sensor=false">
</script>
<script type="text/javascript">
    var map;
    var marker = null;
    function initialize(currentLat, currentLong) {
        // Map is centered over brisbane
        var latlng = new google.maps.LatLng(currentLat, currentLong);
        var myOptions = {
            zoom: 9,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);

        placeMarker(latlng);

        google.maps.event.addListener(map, 'click', function (event) {
            placeMarker(event.latLng);
        });

    }

    //As there is only one point. Returns the Geogrpahical Location of the poll to a createpoll / update poll 
    function getPollLocation() {
        if (marker == null) {
            return null;
        } else { return marker.getPosition(); }
    }

    function getPollLat() {
        if (marker == null) {
            return 0;
        } else {
            return marker.getPosition().lat();
        }
    }

    function getPollLong() {
        if (marker == null) {
            return 0;
        } else {
            return marker.getPosition().lng();
        }
    }

    function setPollLocation() {
        document.getElementById('longitude').value = getPollLong();
        document.getElementById('latitude').value = getPollLat();
    }

    // Adds a marker or moves the markers position on the map.
    function placeMarker(location) {
        if (marker == null) {
            marker = new google.maps.Marker({
                position: location,
                map: map
            });
        } else {
            marker.setPosition(location);
        }
    }

</script>

<script runat="server" language="C#">
void Page_Load(object source, EventArgs e){
        HtmlGenericControl body = (HtmlGenericControl)
        Page.Master.FindControl("MyBody");
        body.Attributes.Add("onload", "initialize(" + ViewData["latitude"] +", "+ ViewData["longitude"] + ")");

    } 
    </script>


</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit Session: <%=ViewData["name"]%></h2>

    <%= Html.ValidationSummary("Edit was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm("EditSession","EditSession", FormMethod.Post)) {%>

         <fieldset>
            <legend>Session Data</legend>
            <p>
                <label for="SESSIONNAME">Session Name:</label>

                <%= Html.TextBox("name",ViewData["name"]) %>

            </p>
            <p>
                <label for="SESSIONTIME">Session Time:</label>

                <%= Html.TextBox("time", ViewData["time"]) %>
                <%= ViewData["date1"] %>

            </p>

                <%= Html.Hidden("pollid", ViewData["pollid"])%>
                <%= Html.Hidden("sessionid", ViewData["sessionid"])%>

                 <label for="map_canvas">Select Session Location:</label>
                 <div id="map_canvas" style="width:360px; height:200px"></div>
                 <%=Html.Hidden("pollid", ViewData["pollid"] )%>
                 <input type="hidden" id="longitude" name="longitude" value="null" />
                 <input type="hidden" id="latitude" name="latitude" value="null" />
            <p>
                <input type="submit" value="Save Changes" onclick="setPollLocation();"/>
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to List", "Index") %>
    </div>
</asp:Content>

