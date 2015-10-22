<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="Sample/css/normalize.css" />
    <script src="jquery-2.1.4.min.js"></script>
    <link href="DashBoardStyle.css" rel="stylesheet" />
    <!-- Important Owl stylesheet -->
    <link rel="stylesheet" href="owl-carousel/owl.carousel.css" />
    <link rel="stylesheet" href="owl-carousel/owl.transitions.css" />
    <%--<link rel="stylesheet" href="owl.carousel2/assets/owl.carousel.css" />--%>
    <!-- Default Theme -->
    <link rel="stylesheet" href="owl-carousel/owl.theme.css" />
    <!-- Include js plugin -->
    <script src="owl-carousel/owl.carousel.min.js"></script>
    <%-- <script src="owl.carousel2/owl.carousel.js"></script>--%>
    <script src="Chart.js-master/Chart.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="bodyDiv">
        <div id="owl-example" class="owl-carousel">
            <div class="item" style="background: none">
               <%-- <div id="caption">
                    Сегодня</div>--%>
                <div class="slogan" style="text-shadow: black 2px 0px,black -2px 0, black 2px 2px,black -2px 2px,black -2px -2px,black 2px -2px,black 0 2px,black 0 -2px,black 0 0 6px,black 0 0 6px,black 0 0 6px;">
                    Мы партнеры для магазинов, кафе, ресторанов</div>
                <div id="CostumersAndProducts">
                    <div id="Costumers">
                        <div id="CountOfCostumers">
                        </div>
                        <div id="CountOfCostumersCaption">
                            Сегодня<br /> мы обслужили <br /> торговых точек</div>
                    </div>
                    <div id="Products">
                        <div id="CountOfProducts">
                        </div>
                        <div id="CountOfProductsCaption">
                            Отгрузили<br /> наименований<br /> продукции</div>
                    </div>
                    <div id="Remains">
                        <div id="CountOfRemains">
                        </div>
                        <div id="CountOfRemainsCaption">
                            Можем отгружать<br /> наименований<br /> продукции</div>
                    </div>
                </div>
                <%-- <img src="" data-thumb="" alt="" title="" />--%>
            </div>
            <div class="item" style="background-color: rgb(48,48,48);">
                <div class="captionOfDiagram">
                    АКБ за две недели</div>
                <div class="AcbAndSku" id="CountOfCostumersAll">
                </div>
                <div class="slogan">
                    Мы партнеры для магазинов, кафе, ресторанов</div>
                <div class="itemOfDiagram">
                    <canvas id="ChartOfCostumers"></canvas>
                </div>
                <%--<img width="0" height="0" src="" data-thumb="" alt="" title="" />--%>
            </div>
            <div class="item">
                <div class="captionOfDiagram">
                    Ассортимент за две недели</div>
                <div class="AcbAndSku" id="CountOfProductsAll">
                </div>
                <div class="slogan">
                    Мы партнеры для магазинов, кафе, ресторанов</div>
                <div class="itemOfDiagram">
                    <canvas id="ChartOfProducts"></canvas>
                </div>
                <%-- <img width="0" height="0" src="" data-thumb="" alt="" title="" />--%>
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">

        var DateMas = new Array;
        var CostumersCountMas = new Array;
        var ProductsCountMas = new Array;
        var CostumersChart;
        var ProductsChart;
        var CountOfCostumersPre;
        var CountOfCostumersForRender;
        var CountOfCostumers;
        var CountOfProductsPre;
        var CountOfProductsForRender;
        var CountOfProducts;
        var owl;

        $(document).ready(function () {

            Chart.defaults.global.scaleFontColor = "#fff";
            Chart.defaults.global.scaleFontFamily = "'Roboto-Light', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'";
            Chart.defaults.global.tooltipFontFamily = "'Roboto-Light', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'";
            Chart.defaults.global.scaleFontSize = 25;
            Chart.defaults.global.tooltipFontSize = 25;
            Chart.defaults.global.animationSteps = 30;
            Chart.defaults.global.tooltipTemplate = "<\%= value \%>";
            Chart.defaults.global.onAnimationComplete = function () {
                this.showTooltip(this.datasets[0].bars, true);
            };
            Chart.defaults.global.tooltipEvents = [];
           

            owl = $("#owl-example");

            owl.owlCarousel({

                navigation: false, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                singleItem: true,
                mouseDrag : false,
                stopOnHover : false,
                autoPlay: 1 * 60 * 1000,
                //transitionStyle : "fadeUp",
                afterMove: function (elem) {
                    var currentItem = this.owl.currentItem;
                    switch (currentItem) {
                        case 0: {
                            this.stop();
                            setTimeout(owlPlay, 1* 60 * 1000);
                            break;
                        }
                        case 1: {
                           console.log(CountOfCostumersForRender,CountOfCostumers); 
                           if (CountOfCostumersForRender===CountOfCostumers){

                             try {
                                CostumersChart.render();
                                console.log('renderCostumer');
                             } catch (err) {
                                console.log(err);
                                CostumersChart = drawCostumers(); 
                                console.log('renderErrCostumers');          
                            }
                            }else{
                                CountOfCostumersForRender = CountOfCostumers;
                                console.log('drawCostumers');
                                CostumersChart = drawCostumers();
                            }    
                            break;
                        }
                        case 2: {
                            console.log(CountOfProductsForRender,CountOfProducts);
                            if (CountOfProductsForRender===CountOfProducts){

                             try {
                                ProductsChart.render();
                                console.log('renderProducts');
                             } catch (err) {
                                console.log(err);
                                ProductsChart = drawProducts();
                                console.log('renderErrProducts');           
                            }
                            }else{
                                CountOfProductsForRender = CountOfProducts;
                                console.log('drawProducts');
                                ProductsChart = drawProducts();
                            }
                            break;
                        }
                    }
                   
                }
            });

            
            $('#CountOfCostumers').text('0');
            $('#CountOfProducts').text('0');
            
            func();
            setInterval(func, 1 * 60 * 1000);

            changeBackground();
            setInterval(changeBackground, 60 * 60 * 1000);

        });

        function owlPlay() {
            owl.trigger('owl.play', 1 * 60 * 1000);
        }


        function changeBackground() {

            RandomInt = randomInteger(3, 31);

            background = 'url(images/wallpaper' + RandomInt + '.png)'

            $('#bodyDiv').css('background-image', background);

        }

        function randomInteger(min, max) {
            var rand = min - 0.5 + Math.random() * (max - min + 1)
            rand = Math.round(rand);
            return rand;
        }


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
       
            var TodayData = $(xml).find("CountOf").eq(0);

            CountOfCostumersPre = $("#CountOfCostumers").text();
            CountOfCostumers = TodayData.find("CountOfCostumers").text();

//          if (CountOfCostumersPre!==CountOfCostumers){

//             try {

//                 CostumersChart.datasets[0].bars[2].value = CountOfCostumers;
//        
//                            
//                  CostumersChart.update();
//                  console.log(CountOfCostumersPre,CountOfCostumers,'CostumersChart.update'); 
//                  } catch (err) {
//                    console.log(err);           
//                 }
//            }


            $({ numberValue: CountOfCostumersPre }).animate({ numberValue: CountOfCostumers }, {
                duration: 8000,
                easing: 'linear',
                step: function () {
                    $('#CountOfCostumers').text(Math.ceil(this.numberValue));
                }
            });

            CountOfProductsPre = $("#CountOfProducts").text();
            CountOfProducts = TodayData.find("CountOfProducts").text();

//            if (CountOfProductsPre!==CountOfProducts){
//                try {
//                          
//                    ProductsChart.update();
//                    console.log(CountOfProductsPre,CountOfProducts,'ProductsChart.update'); 
//                } catch (err) {
//                            console.log(err);    
//                }
//            }

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
            $('#CountOfProductsAll').text('Общий: ' + CountOfProductsAll);


            CountOfRemainsPre = $("#CountOfRemains").text();
            CountOfRemains = CountOfProductsAll;

            $({ numberValue: CountOfRemainsPre }).animate({ numberValue: CountOfRemains }, {
                duration: 8000,
                easing: 'linear',
                step: function () {
                    $('#CountOfRemains').text(Math.ceil(this.numberValue));
                }
            });
 
            DateMas=[];
            CostumersCountMas=[];
            ProductsCountMas=[];

            var DataForDiagram = $(xml).find("DataForDiagram").eq(0);

            DataForDiagram.find("Period").each(function () {

                var Period = $(this).text();
                window.DateMas.push(Period);

            });

            DataForDiagram.find("CountOfCostumers").each(function () {

                var CountOfCostumersForDiagram = $(this).text();
                window.CostumersCountMas.push(+CountOfCostumersForDiagram);

            });

            DataForDiagram.find("CountOfProducts").each(function () {

                var CountOfProductsForDiagram = $(this).text();
                window.ProductsCountMas.push(+CountOfProductsForDiagram);

            });

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
                barValueSpacing: 27,

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
                barValueSpacing: 27,

                //Number - Spacing between data sets within X values
                barDatasetSpacing: 1,

               


            });

            return myLineChart;
        }

        
        $(window).resize(function() {
          
      //   sizeOfCanvas(); 

//        CostumersChart.clear();
//        ProductsChart.clear(); 
//        CostumersChart.resize();
//        ProductsChart.resize(); 
//        CostumersChart.destroy(); 
//        ProductsChart.destroy();  
//        
//        CostumersChart = drawCostumers();
//        ProductsChart = drawProducts();                   
                       
        });


        $(window).load(function() {
            sizeOfCanvas();  
        });
    
        function sizeOfCanvas() {
           
            var widthOfCanvas = $('.itemOfDiagram').css('width').replace('px','');
            var paddingLeftOfCanvas = $('.itemOfDiagram').css('padding-left').replace('px','');
            var paddingRightOfCanvas = $('.itemOfDiagram').css('padding-right').replace('px','');
            var paddingTopOfCanvas = $('.itemOfDiagram').css('padding-top').replace('px','');
            var paddingBottomOfCanvas = $('.itemOfDiagram').css('padding-bottom').replace('px','');
            var heightOfCanvas = $('.itemOfDiagram').css('height').replace('px','');

            var widthOfCanvasNew=widthOfCanvas-paddingLeftOfCanvas-paddingRightOfCanvas+'px';
            var heightOfCanvasNew=heightOfCanvas-paddingTopOfCanvas-paddingBottomOfCanvas+'px';
 


            $('#ChartOfCostumers').attr('width',widthOfCanvasNew);
            $('#ChartOfCostumers').attr('height',heightOfCanvasNew);
            $('#ChartOfProducts').attr('width',widthOfCanvasNew);
            $('#ChartOfProducts').attr('height',heightOfCanvasNew);

            //console.log(widthOfCanvasNew,heightOfCanvasNew);

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