<!DOCTYPE html>
{% load staticfiles %}
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gruppenkasse</title>

    <!-- Bootstrap -->
    <link href="{% static "bootstrap/css/bootstrap.min.css" %}" rel="stylesheet">
    
    <link href="{% static "kasse/css/main.css" %}" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
     <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="{% url 'index' %}">Gruppenkasse</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            {% block veranstaltung_nav %}
                <li class='{% if location == "veranstaltungen" %} active {% endif %}'><a href="{% url 'veranstaltungen' %}">Veranstaltungen</a></li>
            {% endblock %}
            {% block personen_nav %}
                <li {% if location == "personen" %} class='active' {% endif %}><a href="{% url 'personen' %}">Personen</a></li>
            {% endblock %}
            {% block buchungen_nav %}
                <li {% if location == "buchungen" %} class='active' {% endif %}><a href="{% url 'buchungen' %}">Buchungen</a></li>
            {% endblock %}
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

   <div class="container-fluid" id="content">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            {% block sidebar %}
            {% endblock %}
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            {% block content %}
            {% endblock %}
        </div>
      </div>
    </div><!-- /.container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="{% static "bootstrap/js/jquery-2.1.1.min.js" %}"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="{% static "bootstrap/js/bootstrap.min.js" %}"></script>
    
    <script src="{% static "kasse/js/main.js" %}"></script>
  </body>
</html>
