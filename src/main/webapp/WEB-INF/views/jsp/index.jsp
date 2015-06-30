<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html ng-app="technikFDAApp">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>OpenFDA Adverse Drug Event Viewer by Technik Inc.</title>
    <spring:url value="/resources/core/css/MasterDetails.css" var="masterDetailCss" />
  	<spring:url value="/resources/core/js/MasterDetailCtrl.js" var="masterDetailCtrl" />	
  	<spring:url value="/resources/core/images/icnOffice.png" var="icnOfficImage" />
    <link href='https://fonts.googleapis.com/css?family=Raleway:400,600,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="./resources/core/css/normalize.min.css">
    <link rel="stylesheet" href="./resources/core/css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <link href="${masterDetailCss}" rel="stylesheet" />
    <link rel="shortcut icon" href="./resources/core/images/favicon.png">
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
    <script src="./resources/core/js/typeahead.js"></script>
    <script src="./resources/core/js/drugTypeAhead.js"></script>
    <script src="${masterDetailCtrl}" type="text/javascript"></script>
    <script type="text/javascript">
    $(document).ready(function (){
      initiateTypeAhead();
    })
    </script>
  </head>
  <body>
        <div class="header-container">
            <header class="wrapper clearfix">
                <img src="./resources/core/images/openFDA.png" class="header_logo" alt="openFDA Logo" />
            </header>
        </div>
        <div class="main-container">
            <div class="main wrapper clearfix">
                <div class="panel panel-default">
                    <div class="panel-heading">Adverse Drug Event Reports by Country</div>
                    <div class="panel-body">
                        <div class="search_bar">
                            <form class="form-inline">
                              <div class="form-group">
                                <label class="sr-only" for="search_brand">Drug Name</label>
                                <input type="text" class="form-control" id="search_drug" placeholder="Drug name (e.g. aspirin)" value="Aspirin" autocomplete="off">
                              </div>
                              <button type="submit" class="btn btn-default">Search</button>
                            </form>
                        </div>
                        <div 	id="divMasterDetailWrapper" 
                        		ng-controller="MasterDetailCtrl" 
                        		style="position:relative;">
                            <div id="divMasterView" >
                               <div id="{{country.term}}" 
                               			class="cssOneCompanyRecord" 
                               			ng-class="{cssCompanySelectedRecord: country.term == selectedCountry}" 
                               			ng-repeat="country in countries" 
                               			ng-click="selectCountry(country);">
                                    <div class="cssCompanyName">{{country.countryName}} ({{country.count}})</div>
                                     <img src="{{country.imageSrc}}"
                                       title="{{country.countryName}}"
                                       class="cssCustomerIcon" />
                                </div>
                            </div>
                            <div id="divDetailView">
                                <div 	id="Patient Reaction_{{incident.receiptdate}}" 
                                		ng-repeat="incident in listOfIncidents" 
                                		class="cssOneOrderRecord">
                                    <div class="cssOneOrderHeader">
                                        <div class="cssOrderID">Safety Report # {{incident.safetyreportid}} <span class="received">(Received {{incident.receiptdate}})</span></div>
                                    </div>
                                    <div class="incident_table">
                                      <div class="incident_drugs">
                                        <div class="incident_heading">DRUGS</div>
                                        <div class="incident_drug_items" 
                                          ng-repeat='drug in incident.patient.drug'>
                                            <div class="incident_drug_item">{{drug.medicinalproduct}} <span class="characterization">({{getDrugCharacter(drug.drugcharacterization)}})</span></div>
                                        </div>
                                      </div>
                                      <div class="incident_reactions">
                                        <div class="incident_heading">PATIENT REACTIONS</div>
                                        <div class="incident_reaction_items" 
                                          ng-repeat='reaction in incident.patient.reaction'>
                                            <div class="incident_reaction_item">{{reaction.reactionmeddrapt}}</div>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                               
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-container">
            <footer class="wrapper">
                <img src="./resources/core/images/technik_logo.png" alt="Technik Logo" class="technik_logo" />
                <p>
                  Designed & developed by <a href="http://www.technikinc.com" target="_blank">Technik, Inc.</a>
                </p>
                <p>
                    12950 Worldgate Drive, Suite 230, Herndon, VA 20170
                </p>
                <p>
                    Data from <a href="https://open.fda.gov" target="_blank">openFDA</a>
                </p>
                <p ng-controller="MasterDetailCtrl">
					<span> Dataset Date: {{fdaDatasetDate}}</span>
                </p>
            </footer>
            
        </div>
  </body>
</html>