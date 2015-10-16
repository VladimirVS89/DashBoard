<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebDashboard.Dashboard" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="sample/css/normalize.css" />
    <script src="jquery-2.1.4.min.js"></script>
    <link href="DashBoardStyle.css" rel="stylesheet" />

    <!-- Important Owl stylesheet -->
    <link rel="stylesheet" href="owl.carousel/owl-carousel/owl.carousel.css" />
    <%--<link rel="stylesheet" href="owl.carousel2/assets/owl.carousel.css" />--%>

    <!-- Default Theme -->
    <link rel="stylesheet" href="owl.carousel/owl-carousel/owl.theme.css" />
    <!-- Include js plugin -->
    <script src="owl.carousel/owl-carousel/owl.carousel.js"></script>

    <%-- <script src="owl.carousel2/owl.carousel.js"></script>--%>

    <script src="Chart.js-master/Chart.js"></script>


</head>
<body>
    <form id="form1" runat="server">

        <div id="bodyDiv">


            <div id="owl-example" class="owl-carousel">

                <div class="item" style="background: none">
                    <div id="caption">Сегодня</div>
                    <div class="slogan" style="text-shadow: black 0 0 20px,black 0 0 40px,black 0 0 40px,black 0 0 40px">(c) Мы партнеры для магазинов, кафе, ресторанов</div>
                    <div id="CostumersAndProducts">

                        <div id="Costumers">
                            <div id="CountOfCostumers"></div>
                            <div id="CountOfCostumersCaption">Клиенты</div>
                        </div>
                        <div id="Products">
                            <div id="CountOfProducts"></div>
                            <div id="CountOfProductsCaption">Ассортимент</div>
                        </div>


                    </div>
                    <img src="" data-thumb="" alt="" title="" />
                </div>

                <div class="item" style="background-color: rgb(48,48,48);">

                    <div class="captionOfDiagram">АКБ за две предыдущие недели</div>
                    <div class="AcbAndSku" id="CountOfCostumersAll"></div>
                    <div class="slogan">(c) Мы партнеры для магазинов, кафе, ресторанов</div>
                    <div class="itemOfDiagram">
                        <canvas id="ChartOfCostumers" height="650" width="1390"></canvas>
                    </div>

                    <img src="" data-thumb="" alt="" title="" />

                </div>

                <div class="item">

                    <div class="captionOfDiagram">Ассортимент за две предыдущие недели</div>
                    <div class="AcbAndSku" id="CountOfProductsAll"></div>
                    <div class="slogan">(c) Мы партнеры для магазинов, кафе, ресторанов</div>
                    <div class="itemOfDiagram">
                        <canvas id="ChartOfProducts" height="650" width="1390"></canvas>
                    </div>

                    <img src="" data-thumb="" alt="" title="" />

                </div>




            </div>

        </div>




    </form>





    <script type="text/javascript">

        var DateMas = new Array;
        var CostumersCountMas = new Array;
        var ProductsCountMas = new Array;

        $(document).ready(function () {

            var CostumersChart;

            Chart.defaults.global.scaleFontColor = "#fff";
            Chart.defaults.global.scaleFontFamily = "'Roboto-Thin', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'";
            Chart.defaults.global.tooltipFontFamily = "'Roboto-Thin', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'";
            Chart.defaults.global.scaleFontSize = 16;
            Chart.defaults.global.tooltipFontSize = 16;
            Chart.defaults.global.tooltipTemplate = "<\%= value \%>";
            Chart.defaults.global.onAnimationComplete = function () {
                this.showTooltip(this.datasets[0].bars, true);
            };
            Chart.defaults.global.tooltipEvents = [];
           

            


            $("#owl-example").owlCarousel({

                navigation: false, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                singleItem: true,
                autoPlay: 5 * 60 * 1000,
                afterMove: function (elem) {
                    var currentItem = this.owl.currentItem;
                    switch (currentItem) {
                        case 1: {
                            try {
                                CostumersChart.render();
                            } catch (err) {
                                CostumersChart = drawCostumers();
                            }
                        }
                        case 2: {
                            try {
                                ProductsChart.render();
                            } catch (err) {
                                ProductsChart = drawProducts();
                            }
                        }
                    }
                   
                }


            });

            $('#CountOfCostumers').text('0');
            $('#CountOfProducts').text('0');
            func();
            setInterval(func, 5 * 60 * 1000);

        });
        function func() {
            // $("#CountOfCostumers").val("Значение");

            $.ajax({
                url: "data.xml",
                dataType: "xml",
                cache: false,
                success: xmlParser
            });

        }


        function xmlParser(xml) {


            //  $('#load').fadeOut();



            var DataForDiagram = $(xml).find("DataForDiagram").eq(0);

            DataForDiagram.find("Period").each(function () {

                var Period = $(this).text();
                window.DateMas.push(Period);

            });

            DataForDiagram.find("CountOfCostumers").each(function () {

                var CountOfCostumers = $(this).text();
                window.CostumersCountMas.push(+CountOfCostumers);

            });

            DataForDiagram.find("CountOfProducts").each(function () {

                var CountOfProducts = $(this).text();
                window.ProductsCountMas.push(+CountOfProducts);

            });

            console.log(DateMas);
            console.log(CostumersCountMas);
            console.log(ProductsCountMas);


            var TodayData = $(xml).find("CountOf").eq(0);

            var CountOfCostumersPre = $("#CountOfCostumers").text();
            var CountOfCostumers = TodayData.find("CountOfCostumers").text();

            $({ numberValue: CountOfCostumersPre }).animate({ numberValue: CountOfCostumers }, {
                duration: 8000,
                easing: 'linear',
                step: function () {
                    $('#CountOfCostumers').text(Math.ceil(this.numberValue));
                }
            });

            var CountOfProductsPre = $("#CountOfProducts").text();
            var CountOfProducts = TodayData.find("CountOfProducts").text();

            console.log(CountOfProducts);

            $({ numberValue: CountOfProductsPre }).animate({ numberValue: CountOfProducts }, {
                duration: 8000,
                easing: 'linear',
                step: function () {
                    $('#CountOfProducts').text(Math.ceil(this.numberValue));
                }
            });

            var CountOfCostumersAll = TodayData.find("CountOfCostumersAll").text();
            $('#CountOfCostumersAll').text('Общая: '+ CountOfCostumersAll);
            var CountOfProductsAll = TodayData.find("CountOfProductsAll").text();
            $('#CountOfProductsAll').text('Полный: '+ CountOfProductsAll);


        }

        function drawCostumers() {

            // Get context with jQuery - using jQuery's .get() method.
            var ctx = $("#ChartOfCostumers").get(0).getContext("2d");

            // Chart.defaults.global.responsive = true;

           


            var Sun = 177;
            var Mon = 177;
            var Tue = 77;
            var Wed = 77;
            var Thur = 177;
            var Fr = 177;
            var Sat = 177;


            var data = {
                labels: DateMas, //["Понедельник", "Вторник", "Среда", "Черверг", "Пятница", "Суббота"],
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(95,139,149,.5)",
                        strokeColor: "rgba(95,139,149,.8)",
                        highlightFill: "rgba(95,139,149,.75)",
                        highlightStroke: "rgba(95,139,149,1)",
                        data: CostumersCountMas //[Mon, Tue, Wed, Thur, Fr, Sat]
                    }
                ]
            };

            var myLineChart = new Chart(ctx).Bar(data, {
                //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
                scaleBeginAtZero: true,

                //Boolean - Whether grid lines are shown across the chart
                scaleShowGridLines: true,

                //String - Colour of the grid lines
                scaleGridLineColor: "rgba(255,255,255,.08)",

                tooltipFillColor: "rgba(95,139,149,.8)",

                //Number - Width of the grid lines
                scaleGridLineWidth: 1,

                //Boolean - Whether to show horizontal lines (except X axis)
                scaleShowHorizontalLines: true,

                //Boolean - Whether to show vertical lines (except Y axis)
                scaleShowVerticalLines: true,

                //Boolean - If there is a stroke on each bar
                barShowStroke: true,

                //Number - Pixel width of the bar stroke
                barStrokeWidth: 2,

                //Number - Spacing between each of the X value sets
                barValueSpacing: 30,

                //Number - Spacing between data sets within X values
                barDatasetSpacing: 1,



            });

            return myLineChart;
        }

        function drawProducts() {

            // Get context with jQuery - using jQuery's .get() method.
            var ctx = $("#ChartOfProducts").get(0).getContext("2d");

            // Chart.defaults.global.responsive = true;

            var Sun = 177;
            var Mon = 177;
            var Tue = 77;
            var Wed = 77;
            var Thur = 177;
            var Fr = 177;
            var Sat = 177;


            var data = {
                labels: DateMas, //["Понедельник", "Вторник", "Среда", "Черверг", "Пятница", "Суббота"],
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(186,77,81,0.5)",
                        strokeColor: "rgba(186,77,81,0.8)",
                        highlightFill: "rgba(186,77,81,0.75)",
                        highlightStroke: "rgba(186,77,81,1)",
                        data: ProductsCountMas //[Mon, Tue, Wed, Thur, Fr, Sat]
                    }

                ]
            };

            var myLineChart = new Chart(ctx).Bar(data, {
                //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
                scaleBeginAtZero: true,

                //Boolean - Whether grid lines are shown across the chart
                scaleShowGridLines: true,

                //String - Colour of the grid lines.05
                scaleGridLineColor: "rgba(255,255,255,.08)",

                tooltipFillColor: "rgba(186,77,81,.8)",

                //Number - Width of the grid lines
                scaleGridLineWidth: 1,

                //Boolean - Whether to show horizontal lines (except X axis)
                scaleShowHorizontalLines: true,

                //Boolean - Whether to show vertical lines (except Y axis)
                scaleShowVerticalLines: true,

                //Boolean - If there is a stroke on each bar
                barShowStroke: true,

                //Number - Pixel width of the bar stroke
                barStrokeWidth: 2,

                //Number - Spacing between each of the X value sets
                barValueSpacing: 30,

                //Number - Spacing between data sets within X values
                barDatasetSpacing: 1,

               


            });

            return myLineChart;
        }

    </script>
</body>
</html>


<%--  $("#result").load("ajax/test.html");

            $.ajax({
      url: "Dashboard.aspx",
      dataType: "html",
            success: function (data) {
               // alert("Прибыли данные: " + data);
                var html = $(html);
                $("#TextArea1").text(data);
                alert(html.find('input[name="CountOfCostumers"]').val());

               // $('#res-second').text(elem.find('input[name="pass"]').val());  $("#CountOfCostumers").val(
            }
        });--%>