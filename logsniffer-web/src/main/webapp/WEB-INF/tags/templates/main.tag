<%@tag description="Main HTML Template" pageEncoding="UTF-8"%>
<%@attribute name="title" required="true" type="java.lang.String"%>
<%@attribute name="htmlHead" required="false" fragment="true" %>
<%@attribute name="ngModules" required="false"  type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>${title} | logsniffer</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="<%=request.getContextPath()%>/static/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" media="screen" />
		<link href="<%=request.getContextPath()%>/static/bootstrap/3.3.6/css/bootstrap-theme.min.css" rel="stylesheet" />
		<script
			src="<%=request.getContextPath()%>/static/jquery/jquery-1.9.1.min.js"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/1.5.3/angular.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/1.5.3/angular-route.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/1.5.3/angular-animate.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/1.5.3/angular-sanitize.min.js" />"></script>
		<script src="<c:url value="/static/angular-ui/ui-bootstrap-tpls-1.3.2.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/message-center-master/message-center.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script
			src="<%=request.getContextPath()%>/static/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/static/jquery/jquery.endless-scroll.js?v=${logsnifferProps['logsniffer.version']}"></script>
		<script src="<%=request.getContextPath()%>/static/jquery/spin.min.js?v=${logsnifferProps['logsniffer.version']}"></script>
		<script type="text/javascript" src="<c:url value="/static/angular/angular-spinner.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<link href="<c:url value="/static/slider/css/slider.css?v=${logsnifferProps['logsniffer.version']}" />" rel="stylesheet" />
		<script src="<c:url value="/static/slider/js/bootstrap-slider.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<link href="<c:url value="/static/json-formatter/json-formatter.min.css?v=${logsnifferProps['logsniffer.version']}" />" rel="stylesheet" />
		<script src="<c:url value="/static/json-formatter/json-formatter.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>	
		<script src="<c:url value="/static/screenfull/screenfull.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script src="<c:url value="/static/screenfull/angular-screenfull.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script src="<c:url value="/static/ngclipboard/clipboard.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script src="<c:url value="/static/ngclipboard/ngclipboard.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script src="<c:url value="/static/scrollintoview/jquery.scrollintoview.min.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<link href="<c:url value="/static/fontawesome/css/font-awesome.min.css?v=${logsnifferProps['logsniffer.version']}" />" rel="stylesheet" />
	    <script src="<c:url value="/static/date.js?v=${logsnifferProps['logsniffer.version']}" />"></script>
		<script src="<%=request.getContextPath()%>/static/logsniffer.js?v=${logsnifferProps['logsniffer.version']}"></script>
		<script src="<%=request.getContextPath()%>/static/logsniffer.ng-core.js?v=${logsnifferProps['logsniffer.version']}"></script>
		<link href="<c:url value="/static/logsniffer.css" />?v=${logsnifferProps['logsniffer.version']}" rel="stylesheet" />
		<script type="text/javascript">
			Spinner.defaults={ lines: 8, length: 4, width: 3, radius: 5 };
			
			$(function() {
				$(".help-popup").popover({placement:"top"});
			});
		</script>
		<script type="text/javascript">
			LogSniffer.config.contextPath = '<%=request.getContextPath()%>';
			LogSniffer.config.version = '${logsnifferProps['logsniffer.version']}';
			var LogSnifferNgApp=angular.module('LogSnifferNgApp', ['LogSnifferCore', 'ui.bootstrap', 'angularSpinner', 'MessageCenterModule', 'angularScreenfull','ngclipboard',${ngModules}]);
			LogSnifferNgApp.config(function($controllerProvider, $compileProvider, $filterProvider, $provide)
		    {
			    LogSnifferNgApp.controllerProvider = $controllerProvider;
			    LogSnifferNgApp.compileProvider    = $compileProvider;
			    LogSnifferNgApp.filterProvider     = $filterProvider;
			    LogSnifferNgApp.provide            = $provide;
			});
			LogSnifferNgApp.controller("BeanWizardController", LogSniffer.ng.BeanWizardController);
			LogSnifferNgApp.controller("LogSnifferRootController", ['$scope', '$uibModal', '$document', function($scope, $uibModal, $document) {
				$scope.contextPath = LogSniffer.config.contextPath;
				$scope.version = LogSniffer.config.version;
				LogSniffer.ng.dateFilter = angular.injector(["ng"]).get("$filter")("date");
			    $scope.zoomEntry = function (context) {
					$uibModal.open({
				      templateUrl: $scope.contextPath + '/ng/entry/zoomEntry.html',
				      controller: 'ZoomLogEntryCtrl',
				      size: 'lg',
				      windowClass: 'zoom-entry-modal',
				      appendTo: context.appendTo,
				      resolve: {
				        context: function () {
				          return context;
				        }
				      }
				    });
			    };
				$scope.systemNotificationSummary = {worstLevel:'${not empty systemNotificationSummary.worstLevel?systemNotificationSummary.worstLevel:''}', count: ${systemNotificationSummary.count}};
				$scope.$on("systemNotificationSummaryChanged", function(event, summary) {
					$scope.systemNotificationSummary = summary;
				});
			}]);
			LogSnifferNgApp.filter('escape', function() {
				  return window.encodeURIComponent;
			});
			$.LogSniffer.zoomLogEntry = function(context) {
				angular.element(document.body).scope().zoomEntry(context);
			};
		</script>
		<jsp:invoke fragment="htmlHead"/>
	</head>
	<body ng-app="LogSnifferNgApp" ng-controller="LogSnifferRootController" class="ng-cloak">
		<div id="body-wrapper">
			<jsp:doBody />		
			<div class="push"></div>
		</div>
		<hr>
		<footer>
			<p>logsniffer, v${logsnifferProps['logsniffer.version']} - <a href="http://www.logsniffer.com">www.logsniffer.com</a><br>&copy; Scaleborn 2016</p>
		</footer>
	</body>
</html>