//= require fullcalendar/moment.min.js
//= require daterangepicker/daterangepicker.js

$(document).ready(function() {

  var hostname = window.location.origin;

  function emptyOptionTagsFor(element) {
    element.find('option').remove();
  }

  $("#accountsForm").validate({
    rules: {
      "account_header": {
        required: true
      },
      "account[name]": {
        required: true,
        minlength: 5,
        maxlength: 100
      },
      "account[description]": {
        required: true
      },
      "account[account_type_id]": {
        required: true
      }
    }
  });

  $("#accountHeaderSelectTag").change(function() {
    var $this = $(this);
    var accountHeaderID = $this.val();

    emptyOptionTagsFor($("#accountSubTypeSelectTag"));
    emptyOptionTagsFor($("#accountTypeSelectTag"));

    if (accountHeaderID != "") {
      var accountSubType  = $("#accountSubTypeSelectTag");
      var accountType = $("#accountTypeSelectTag");
      var parentFormGroup = accountSubType.parent().parent();

      accountSubType.prop("disabled", true);
      accountType.prop("disabled", true);

      $("#accountHeaderHelpBlock").remove();
      parentFormGroup.removeClass('has-error');

      $.ajax({
        type:  'GET',
        url:   hostname + '/account_headers/' + accountHeaderID + '/account_sub_headers',
        success: function() {
          accountSubType.prop("disabled", false);
        },
        error: function() {
          var helpBlock = $("<span id='accountHeaderHelpBlock' class='help-block m-b-none'>Error: there are no associated records.</span>");
          accountSubType.after(helpBlock);
          parentFormGroup.addClass('has-error');
        }
      });
    }
  });

  $("#accountSubTypeSelectTag").change(function() {
    var $this = $(this);
    var accountSubHeaderID = $this.val();
    emptyOptionTagsFor($("#accountTypeSelectTag"));

    if (accountSubHeaderID != "") {
      var accountType = $("#accountTypeSelectTag");
      var parentFormGroup = accountType.parent().parent();

      accountType.prop("disabled", true);

      $("#accountSubTypeHelpBlock").remove();
      parentFormGroup.removeClass('has-error');


      $.ajax({
        type:  'GET',
        url:   hostname + '/account_sub_headers/' + accountSubHeaderID + '/account_lists',
        success: function() {
          accountType.prop("disabled", false);
        },
        error: function() {
          var helpBlock = $("<span id='accountSubTypeHelpBlock' class='help-block m-b-none'>Error: there are no associated records.</span>");
          accountType.after(helpBlock);
          parentFormGroup.addClass('has-error');
        }
      });
    }
  });

  var margin = {top: 20, right: 120, bottom: 20, left: 120},
    width = 1050 - margin.right - margin.left,
    height = 800 - margin.top - margin.bottom;

  var i = 0,
      duration = 750,
      root;

  var tree = d3.layout.tree()
      .size([height, width]);

  var diagonal = d3.svg.diagonal()
      .projection(function(d) { return [d.y, d.x]; });

  var svg = d3.select("#tree").append("svg")
      .attr("width", width + margin.right + margin.left)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  d3.json("/accounts/view.json", function(error, flare) {
    if (error) throw error;

    root = flare;
    root.x0 = height / 2;
    root.y0 = 0;
    function collapse(d) {
      if (d.children) {
        d._children = d.children;
        d._children.forEach(collapse);
        d.children = null;
      }
    }
    root.children.forEach(collapse);
    update(root);
  });

  d3.select(self.frameElement).style("height", "800px");

  function update(source) {

    // Compute the new tree layout.
    var nodes = tree.nodes(root).reverse(),
        links = tree.links(nodes);

    // Normalize for fixed-depth.
    nodes.forEach(function(d) { d.y = d.depth * 180; });

    // Update the nodes…
    var node = svg.selectAll("g.node")
        .data(nodes, function(d) { return d.id || (d.id = ++i); });

    // Enter any new nodes at the parent's previous position.
    var nodeEnter = node.enter().append("g")
        .attr("class", "node")
        .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
        .on("click", click);

    nodeEnter.append("circle")
        .attr("r", 1e-6)
        .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

		var text = nodeEnter.append("text")
				.attr("x", function(d) { return d.children || d._children ? -10 : 10; })
				.attr("dy", ".10em")
				.attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
		text.append("tspan")
				.text(function(d) { return "[" })
		text.append("tspan")
				.text(function(d) { return d.name; });
		text.append("tspan")
				.text(function(d) { return ", " })
		text.append("tspan")
				.text(function(d) { return d.amount; })
				.style("font-weight", function(d) { return d.level; })
		text.append("tspan")
				.text(function(d) { return "]" })
    // Transition nodes to their new position.
    var nodeUpdate = node.transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

    nodeUpdate.select("circle")
        .attr("r", 4.5)
        .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

    nodeUpdate.select("text")
        .style("fill-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    var nodeExit = node.exit().transition()
        .duration(duration)
        .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
        .remove();

    nodeExit.select("circle")
        .attr("r", 1e-6);

    nodeExit.select("text")
        .style("fill-opacity", 1e-6);

    // Update the links…
    var link = svg.selectAll("path.link")
        .data(links, function(d) { return d.target.id; });

    // Enter any new links at the parent's previous position.
    link.enter().insert("path", "g")
        .attr("class", "link")
        .attr("d", function(d) {
          var o = {x: source.x0, y: source.y0};
          return diagonal({source: o, target: o});
        });

    // Transition links to their new position.
    link.transition()
        .duration(duration)
        .attr("d", diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition()
        .duration(duration)
        .attr("d", function(d) {
          var o = {x: source.x, y: source.y};
          return diagonal({source: o, target: o});
        })
        .remove();

    // Stash the old positions for transition.
    nodes.forEach(function(d) {
      d.x0 = d.x;
      d.y0 = d.y;
    });
  }

  // Toggle children on click.
  function click(d) {
    if (d.children) {
      d._children = d.children;
      d.children = null;
    } else {
      d.children = d._children;
      d._children = null;
    }
    update(d);
  }

  $('#treeZoomIn').click(function() {
    value = $('#treeZoomIn').val();
    if(value > 0) {
      $('#treeZoomOut').val(parseInt(value)-1);
      $('#treeZoomIn').val(parseInt(value)+ 1);
      $('#tree').animate({ 'zoom': value }, 400);
    }
  });

  $('#treeZoomOut').click(function() {
    value = $('#treeZoomOut').val();
    if(value > 0) {
      $('#treeZoomOut').val(parseInt(value)- 1);
      $('#tree').animate({ 'zoom': value }, 400);
      $('#treeZoomIn').val(parseInt(value)+ 1);
    }
  });

  $("#reportrange").daterangepicker(
    {
      format: 'DD/MM/YYYY',
      startDate: $("#reportrange").data('start-date'),
      endDate: moment(),
      minDate: $("#reportrange").data('start-date'),
      maxDate: moment(),
      showDropdowns: true,
      showWeekNumbers: true,
      timePicker: false,
      timePickerIncrement: 1,
      timePicker12Hour: true,
      ranges: {
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
    },
    function(start, end, label) {
      formatted_start_date = start.format('MMMM D, YYYY');
      formatted_end_date   = end.format('MMMM D, YYYY');
      $('#reportrange span').html(formatted_start_date + ' - ' + formatted_end_date);
      $("#accountTreeWaveAnimation").removeClass('hidden');
      var url = "/accounts/view.json?start_date=" + formatted_start_date + "&end_date=" + formatted_end_date;
      d3.json(url, function(error, flare) {
        if (error) throw error;

        $("#accountTreeWaveAnimation").addClass('hidden');
        root = flare;
        root.x0 = height / 2;
        root.y0 = 0;
        function collapse(d) {
          if (d.children) {
            d._children = d.children;
            d._children.forEach(collapse);
            d.children = null;
          }
        }
        root.children.forEach(collapse);
        update(root);
      });
    }
  );
});
