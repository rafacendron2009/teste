<!--#include file="conn.asp" -->
<%		
	set Rst = Server.CreateObject("ADODB.RecordSet")	
%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8" />

    <link href="css/spectrum.css" rel="stylesheet" />
    <link href="jvectormap/jquery-jvectormap-2.0.3.css" rel="stylesheet" />
    <!--       <link href="jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" />-->
    <script src="js/jquery-1.8.2.min.js"></script>
    <script src="js/spectrum.js"></script>
    <script src="js/hilitor.js"></script>
    <script src="jvectormap/jquery-jvectormap-2.0.3.min.beto.js"></script>
    <script src="jvectormap/mapa-1513600198.js"></script>
    <script src="jvectormap/jquery-jvectormap-us-lcc.js"></script>
    <script type="text/javascript">

        function teste() {
            var divText = document.getElementById('content').innerHTML;
            console.log(divText);
            var myWindow = window.open('', '', 'width=1300,height=800');
            var doc = myWindow.document;
            doc.open();
            doc.write('<link href="jvectormap/jquery-jvectormap-2.0.3.css" rel="stylesheet" />');
            doc.write('<link href="css/teste.css" rel="stylesheet" />');
            doc.write(divText);

            setTimeout(function () {
                myWindow.print();
                myWindow.close();
            }, 100);
        }
    </script>

    <style>
        html, body {
            margin: 0;
        }

        /*@font-face {
            font-family: Futura_Bk_BT;
            src: url('css/font/tt0140m_.ttf');
        }

body{
	font-family: Futura_Bk_BT, arial, sans-serif;
	font-size: 14px;
	line-height: 23px;
    color: #104122;

}*/


        .jvectormap-legend {
            width: 275px;
            font-family: Tahoma;
            line-height: 20px;
        }

        .jvectormap-legend-title {
            font-size: 11px;
        }

        .jvectormap-legend-cnt-h .jvectormap-legend-tick {
            width: 33%;
        }


        .btn {
            cursor: pointer;
            text-align: center;
            width: 140px !important;
            height: 35px !important;
            background: #AFCB07;
            background-image: -webkit-linear-gradient(top, #AFCB07, #97ad09);
            background-image: -moz-linear-gradient(top, #AFCB07, #97ad09);
            background-image: -ms-linear-gradient(top, #AFCB07, #97ad09);
            background-image: -o-linear-gradient(top, #AFCB07, #97ad09);
            background-image: linear-gradient(to bottom, #AFCB07, #97ad09);
            -webkit-border-radius: 15;
            -moz-border-radius: 15;
            border-radius: 10px;
            color: #ffffff;
            padding: 10px 17px 10px 17px;
            text-decoration: none;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            float: left;
            line-height: 20px;
            margin-left: 4px;
            border: 1px solid #629220;
        }



            .btn:hover {
                background: #AFCB07;
                background-image: -webkit-linear-gradient(top, #AFCB07, #AFCB07);
                background-image: -moz-linear-gradient(top, #AFCB07, #AFCB07);
                background-image: -ms-linear-gradient(top, #AFCB07, #AFCB07);
                background-image: -o-linear-gradient(top, #AFCB07, #AFCB07);
                background-image: linear-gradient(to bottom, #AFCB07, #AFCB07);
                text-decoration: none;
            }

        button {
            float: left
        }

        #mapaSc {
            width: 100%;
            height: 610px;
            margin: 0px auto;
            position: relative
        }

        #inner1 {
            height: 55px;
            width: 335px;
            bottom: 0px;
            left: 0;
            position: absolute;
            background: black;
            color: white;
            text-align: center;
            line-height: 50px;
            z-index: 9999;
            border-radius: 3px;
            margin: 0 10px 10px 10px;
            padding: 3px 3px 1px 3px;
            font-size: 14px;
        }

        #inner2 {
            height: 55px;
            top: 0px;
            right: 0;
            position: absolute;
            color: white;
            text-align: center;
            line-height: 50px;
            z-index: 9999;
            border-radius: 3px;
            margin: 0 10px 10px 10px;
            padding: 15px;
        }
    </style>
</head>
<body>

    <div class="mapa">

        <%  

    Function unaccent(strg)
        With Server.CreateObject("Adodb.Stream")
        .Charset = "ascii"
        .Open
        .WriteText strg
        .Position = 0
        unaccent = replace(.ReadText,"`","")
        End With
    End Function

    CorMunicipios="verde"
    CorMunicipioConcluido="verdeclaro"
    CorMunicipios2="branco"
    coresMapa=""
    LeiMunicipais=""
    Programas=""
    NomeMunicipios=""

    Dim TodosProgramas(20) 
    TodosProgramas(0)=""

    Dim TotalMunicipios
    TotalMunicipios=0
       
   	Rst.open "Select * From DadosMunicipios",GetConnectionSQL
	Do While Not Rst.Eof
        Municipio=Replace(Rst("Municipio"),"MUNICÍPIO DE ","")
        Municipio= "'" & lcase(Replace(unaccent(Municipio),chr(32),"")) &  "'"
        if Rst("LeiMunicipal")<>"" then LeiMunicipal = Rst("LeiMunicipal") Else LeiMunicipal=""
        
        if Rst("Consorciado")=-1 then 
            TotalMunicipios=TotalMunicipios+1
            Cor = CorMunicipios
            TodosProgramas(0)=TodosProgramas(0) & Municipio & ":" & "'" & Cor & "'," 
        Else 
            Cor = CorMunicipios2
        End If

        If Rst("LicitacaoCompartilhada")=-1 Then 
            TodosProgramas(1)=TodosProgramas(1) & Municipio & ":" & "'" & Cor & "',"
        End If

        If Rst("IluminacaoPublica")=-1 Then 
            TodosProgramas(2)=TodosProgramas(2) & Municipio & ":" & "'" & Cor & "',"
        End If

         If Rst("PlanoDiretor")=-1 Then 
            TodosProgramas(3)=TodosProgramas(3) & Municipio & ":" & "'" & Cor & "',"
        End If
         If Rst("MobilidadeUrbana")=-1 Then 
            TodosProgramas(4)=TodosProgramas(4) & Municipio & ":" & "'" & Cor & "',"
        End If
            If Rst("DiagnosticoSocioAmbientalExecucao")=-1  then
             TodosProgramas(5)=TodosProgramas(5) & Municipio & ":" & "'" & Cor & "',"
            End If

            If Rst("DiagnosticoSocioAmbiental")=-1  then
            TodosProgramas(5)=TodosProgramas(5) & Municipio & ":" & "'" & CorMunicipioConcluido & "',"
            TotalMunicipiosConcluidos =+ TotalMunicipiosConcluidos
             End If
  
       
        NomeMunicipios = NomeMunicipios & Municipio & ":'" & Replace(Rst("Municipio"),"MUNICÍPIO DE ","") & "',"
        coresMapa=coresMapa & Municipio & ":" & "'" & Cor & "',"
        LeiMunicipais=LeiMunicipais & Municipio & ":" & "'" & LeiMunicipal & "',"
                    
    Rst.Movenext
        ProgramasMunicipio=""
        Loop
    Rst.Close

    coresMapa=left(coresMapa,len(coresMapa)-1)
    NomeMunicipios=left(NomeMunicipios,len(NomeMunicipios)-1)

        %>

        <script type="text/javascript">

            var programas = {};
            var map = "";
            var coresMapa = {  <%=coresMapa%> };
            var NomesMunicipios = {  <%=NomeMunicipios%> };
            var showregiontip = true;
            programas[0] = {  <%=TodosProgramas(0) %> };
            programas[1] = {  <%=TodosProgramas(1) %> };
            programas[2] = {  <%=TodosProgramas(2) %> };
            programas[3] = {  <%=TodosProgramas(3) %> };
            programas[4] = {  <%=TodosProgramas(4) %> };
            programas[5] = {  <%=TodosProgramas(5) %> };
            
            var selected = [];
            programas[20] = {};
            programas[99] = {};
            var LeiMunicipais = {  <%=LeiMunicipais%> };
            //var linksMapa = { 'aguadoce': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/5', 'capinzal': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/60', 'catanduvas': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/62', 'ervalvelho': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/85', 'hervaldoeste': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/105', 'ibicare': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/107', 'joacaba': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/136', 'lacerdopolis': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/140', 'luzerna': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/151', 'ouro': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/177', 'trezetilias': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/274', 'vargembonita': '/index/detalhes-municipio/codMapaItem/42462/codMunicipio/285', };

            $(function () {
                markerIndex = 0,
                    markersCoords = {};
                map = new jvm.Map({
                    map: 'mapa-svg',
                    container: $('#mapaSc'),
                    backgroundColor: '#F1F1F1',
                    regionsSelectable: true,
                    zoomOnScroll: false,


                    //Add markers onload
                    //markers: [
                    //      {latLng: [69.07756508411818, -164.41906470061932], name: 'Vatican City'}
                    //],

                    markerStyle: {
                        initial: {
                            fill: markercolor
                            //stroke: 'white'
                        }
                    },

                    regionStyle: {
                        initial: {
                            fill: '#AFCB07'
                        },
                        hover: {
                            "fill-opacity": 0.5,
                            //fill: '#218558',
                            cursor: 'pointer'
                        },
                        selected: {
                            //fill: '#F4A582'
                            fill: '#F22534'
                        }
                    },


                    //Tooltip onmouseover
                    onRegionTipShow: function (event, label, code) {
                        if (LeiMunicipais[code] != '') {
                            if (showregiontip) label.html('<b>' + label.html() + '</b></br>' + "Lei Municipal nº " + LeiMunicipais[code]);
                        } else {
                            if (showregiontip) label.html('<b>' + label.html() + '</b></br>' + "Não Consorciado");
                        }

                        showregiontip = true;
                    },

                    onRegionClick: function (event, code) {
                        regions = map.regions;

                        var centroid = map.getRegionCentroid(code);
                        var markername = map.getRegionName(code);
                        var bbox = regions[code].element.shape.getBBox(),
                            xcoord = (((bbox.x + bbox.width / 2) + map.transX) * map.scale),
                            ycoord = (((bbox.y + bbox.height / 2) + map.transY) * map.scale);

                        centroid = map.pointToLatLng(xcoord, ycoord);
                        //map.addMarker(markerIndex, {latLng: [centroid.lat, centroid.lng], name: markername}, []);   

                        //Bind click event
                        $(this).on('click', function (event) {
                            //Coordenadas do click
                            var latLng = map.pointToLatLng(
                                event.pageX - map.container.offset().left,
                                event.pageY - map.container.offset().top
                            );
                            targetCls = $(event.target).attr('class');
                            marker = document.getElementById("AddMarkers").checked;
                            saveselection = document.getElementById("SaveSelection").checked;

                            if (saveselection) {
                                var element = {};
                                element[code] = "vermelho";
                                Object.assign(programas[20], element);

                                //Atualiza regions values
                                map.series.regions[0].clear();
                                map.series.regions[0].setValues(programas[20]);
                                SetLegend(programas[20]);
                            }

                            if (marker) {
                                if (latLng && (!targetCls || (targetCls && $(event.target).attr('class').indexOf('jvectormap-marker') === -1))) {
                                    //Force selected to prevent deselect on add marker
                                    map.setSelectedRegions(code);
                                    markersCoords[markerIndex] = latLng;
                                    map.addMarker(code, { latLng: [latLng.lat, latLng.lng], name: markername, style: { fill: markercolor } });
                                    markerIndex += 1;



                                }
                            }
                        });


                        //                            if (linksMapa[code]) {
                        //                                window.location = linksMapa[code];
                        //                            }
                    },


                    onRegionOut: function (e, code) {
                        $(this).unbind('click');
                    },

                    onRegionOver: function (evt, code) {
                        regions = map.regions;
                        var bbox = regions[code].element.shape.getBBox(),
                            xcoord = (((bbox.x + bbox.width / 2) + map.transX) * map.scale),
                            ycoord = (((bbox.y + bbox.height / 2) + map.transY) * map.scale);
                        var centroid = map.pointToLatLng(xcoord, ycoord);
                    },


                    series: {
                        regions: [{
                            scale: { "verde": "#175A3B", "branco": "#AFCB07", /*"vermelho": "#F22534",*/"verdeclaro":"#00ff00" },
                            attribute: 'fill',
                            normalizeFunction: 'polynomial',
                            values: coresMapa,
                            legend: {
                               
                                horizontal: true,
                                cssClass: 'jvectormap-legend-bg',
                                title: 'Municípios',
                                labelRender: function (v) {
                                    return {
                                        "verde": 'Consorciado',
                                        "branco": 'Não Consorciado',
                                        "vermelho": 'Seleção',
                                        "verdeclaro" : 'Programa Concluido'
                                    }[v];
                                }
                            }
                        }],
                    },


                    onMarkerTipShow: function (e, label, code) {
                        //map.tip.text(markersCoords[code].lat.toFixed(2)+', '+markersCoords[code].lng.toFixed(2));
                        //map.tip.text(map.getRegionName(code));
                    },
                    onMarkerClick: function (e, code) {
                        map.tip.hide();
                        map.removeMarkers([code]);
                        showregiontip = false;

                    }
                });


                //Add markers on map click
                map.container.click(function (e) {
                    //var latLng = map.pointToLatLng(
                    //        e.pageX - map.container.offset().left,
                    //        e.pageY - map.container.offset().top
                    //    ),
                    //    targetCls = $(e.target).attr('class');

                    //marker=document.getElementById("AddMarkers").checked;
                    //if(marker){
                    //    if (latLng && (!targetCls || (targetCls && $(e.target).attr('class').indexOf('jvectormap-marker') === -1))) {
                    //        //markersCoords[markerIndex] = latLng;
                    //        //map.addMarker(markerIndex, {latLng: [latLng.lat, latLng.lng]});
                    //        //markerIndex += 1;    
                    //    }
                    //}

                });

                SetLegend(programas[0]);

                //map.container.dblclick(function(e){
                //    alert("teste");
                //});

                //var bb = map.regions[code].element.shape.getBBox();
                //console.log(bb);



                //---------------------TESTES--------------- 
                // Extend current map implementation
                jvm.Map.prototype.getRegionCentroid = function (region) {
                    if (typeof region == "string")
                        regions = map.regions;
                    var bbox = regions[region].element.shape.getBBox(),
                        xcoord = (((bbox.x + bbox.width / 2) + map.transX) * map.scale),
                        ycoord = (((bbox.y + bbox.height / 2) + map.transY) * map.scale);


                    if (region == "itapoa") {
                        //console.log("region: " + region);
                        //console.log("xcoord: " + xcoord);
                        //console.log("ycoord: " + ycoord);
                        //var latlng=this.pointToLatLng(xcoord, ycoord); 
                        //console.log("lat: " + latlng.lat);
                        //console.log("lng: " + latlng.lng);

                        //xcoord = bbox.x + bbox.width/2,
                        //ycoord = bbox.y + bbox.height/2;
                        //var latlng2=this.pointToLatLng(xcoord, ycoord);
                        //console.log("xcoord: " + xcoord);
                        //console.log("ycoord: " + ycoord);
                        //console.log("lat: " + latlng2.lat);
                        //console.log("lng: " + latlng2.lng);
                    }

                    return this.pointToLatLng(xcoord, ycoord);
                }

                jvm.Map.prototype.addMarkerToRegion = function (i) {
                    var centroid = map.getRegionCentroid(i);
                    var markername = map.getRegionName(i);
                    map.addMarker(markerIndex, { latLng: [centroid.lat, centroid.lng], name: markername }, []);
                    markersCoords[markerIndex] = centroid;
                    markerIndex += 1;
                }


                //---------------LOOP IN REGIONS TO ADD MARKER ON CENTER----------------
                //regions=map.regions;
                //for ( region in regions ){ // only interested in a subset of countries                    
                //    if (region=="fraiburgo"){        
                //var element = regions[region].element.shape;
                //bbox = element.getBBox();
                //point_ori = [bbox.x + bbox.width/2, bbox.y + bbox.height/2];
                //point = map.pointToLatLng(point_ori[0],point_ori[1]); // convert it to lat lon
                //var b = bbox;
                //xcoord = (((bbox.x + bbox.width/2)+map.transX)*map.scale),
                //ycoord = (((bbox.y + bbox.height/2)+map.transY)*map.scale);
                //latLng=map.pointToLatLng(xcoord, ycoord);                         
                //map.addMarkerToRegion(region);

                //var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
                //text.setAttribute("x", point_ori[0]);
                //text.setAttribute("y", point_ori[1]);
                //text.textContent = map.getRegionName(region);
                //text.setAttribute("font-size", "12");

                //if (element.parentNode) {
                //    element.parentNode.appendChild(text);
                //}

                //    } 
                //};


            });

            function AddMarkers(Programa) {
                map.removeAllMarkers();
                regions = map.regions;
                var Programa = programas[Programa]
                for (region in regions) { // only interested in a subset of countries    
                    Object.keys(Programa).forEach(function (key) {
                        if (key === region) {
                            console.log(region)
                            map.addMarkerToRegion(region);
                        }
                    });
                };
            }

            function RetNumeroMunicipios(Programa) {
                NumMunicipios = 0;
                regions = map.regions;
                for (region in regions) { // only interested in a subset of countries    
                    Object.keys(programas[Programa]).forEach(function (key) {
                        if (key == region) {
                            NumMunicipios += 1;
                        }
                    });
                };
                return NumMunicipios;
            }

            function ResetRegions(Programa) {

                if (Programa == 0) {
                    document.getElementById("tituloMunicipios").innerHTML = "São Municípios consorciados ao CIMCATARINA:";
                    document.getElementById("inner1").innerHTML = "Municípios Consorciados: " + RetNumeroMunicipios(Programa);
                } else if (Programa == 1) {
                    document.getElementById("tituloMunicipios").innerHTML = "Participantes da Licitação Compartilhada:";
                    document.getElementById("inner1").innerHTML = "Participantes da Licitação Compartilhada: " + RetNumeroMunicipios(Programa);
                } else if (Programa == 2) {
                    document.getElementById("tituloMunicipios").innerHTML = "Participantes da Iluminação Pública:";
                    document.getElementById("inner1").innerHTML = "Participantes da Iluminação Pública: " + RetNumeroMunicipios(Programa);
                } else if (Programa == 3) {
                    document.getElementById("tituloMunicipios").innerHTML = "Participantes do Plano Diretor: ";
                    document.getElementById("inner1").innerHTML = "Participantes do Plano Diretor: " + RetNumeroMunicipios(Programa);
                } else if (Programa == 4) {
                    document.getElementById("tituloMunicipios").innerHTML = "Participantes da Mobilidade Urbana: ";
                    document.getElementById("inner1").innerHTML = "Participantes da Mobilidade Urbana: " + RetNumeroMunicipios(Programa);
                } else if (Programa == 5) {
                    document.getElementById("tituloMunicipios").innerHTML = "Participantes do Diagnóstico Socioambiental: ";
                    document.getElementById("inner1").innerHTML = "Participantes do  Diagnóstico Socioambiental: " + RetNumeroMunicipios(Programa);
                }

                if (Programa == 99) {
                    programas[20] = {};
                }
                //marker=document.getElementById("AddMarkers").checked;
                marker = false;

                //Reset all the series and show the map with the initial zoom.
                //map.reset();
                //Remove all markers from the map.
                map.removeAllMarkers();
                //Remove the selected state from all the currently selected regions.
                map.clearSelectedRegions();
                //Remove regions only
                map.series.regions[0].clear();
                setTimeout(function () {
                    //obj = Object.keys(coresMapa).length;
                    //console.log(obj);

                    //Altera valor da chave no objeto:
                    //coresMapa.araquari = "verde";
                    //console.log(coresMapa);
                    //Atualiza regions values
                    map.series.regions[0].setValues(programas[Programa]);
                    SetLegend(programas[Programa]);


                }, 50);

                if (marker) {
                    AddMarkers(Programa);
                }

                //map.setSelectedRegions('fraiburgo');

            }

            function SetLegend(Programa) {
                document.getElementById("municipios").innerHTML = "";
                regions = map.regions;
                for (region in regions) { // only interested in a subset of countries    
                    Object.keys(Programa).forEach(function (key) {
                        if (key == region) {
                            document.getElementById("municipios").innerHTML += "<div title='Lei Municipal nº " + LeiMunicipais[region] + "' onclick=HighlightRegion('" + region + "'); style='display:inline-block;width:100%;padding:5 0 5 0;cursor:pointer'><a onclick=HighlightRegion('" + region + "');return false>" + NomesMunicipios[region] + "</a></div>";
                        }
                    });
                };
                //document.getElementById("municipios").innerHTML="</ol>";
            }
            function HighlightRegion(code) {
                map.clearSelectedRegions();
                map.setSelectedRegions(code);
                //var zParams = {region: code, scale: 2, animate: true};
                //map.setFocus(zParams);

                var centroid = map.getRegionCentroid(code);
                map.setFocus({ lat: centroid.lat, lng: centroid.lng, x: 1, y: 1, scale: 1 });
                map.setFocus({ lat: centroid.lat, lng: centroid.lng, x: 1, y: 1, scale: 2, animate: true });
            }

            function Highlight(text) {
                var myHilitor = new Hilitor("mapaSc");
                myHilitor.apply(text);
            }

        </script>

        <div class="divleft" style="width: 420px;">

            <div class="titulo" id="tituloMunicipios">
                São Municípios consorciados ao CIMCATARINA:
            </div>

            <div id="municipios" style="overflow: auto; width: 400px; height: 35vh; padding: 0px; margin-bottom: 10px;">
            </div>

            <div style="margin-bottom: 10px; display: none">
                <div style="padding-top: 10px">
                    <label for="SaveSelection">Guardar seleção?</label><input id="SaveSelection" type="checkbox" />
                    <label for="AddMarkers">Seleção com marcador?</label><input id="AddMarkers" type="checkbox" />
                    <label for="CorMarcador">Cor do marcador:</label><input type='text' id="CorMarcador" />
                </div>
            </div>

        </div>

        <div class="divright" style="width: 560px;">
            <div class="titulo">
                Possíveis municípios a integrarem o CIMCATARINA:<br>
            </div>
            <ul>
                <li>TODOS OS MUNICÍPIOS DO ESTADO DE SANTA CATARINA.</li>
                <li><a href="/upload-images/docs/Municípios/Modelos Adesão CIMCATARINA-n.doc" target="_blank">&#8203;Minuta do Projeto de Lei para adesão ao CIMCATARINA.</a></li>
            </ul>
        </div>

        <div class="" style="clear: both;"></div>

        <div name="button" style="margin-top: 0px; margin-bottom: 0px; width: 1080px;">

            <a class="btn" id="Consorciados" onclick="ResetRegions(0);return false" href="#">Consorciados</a>
            <a class="btn" id="LicitacaoCompartilhada" onclick="ResetRegions(1);return false" href="#">Licitação Compartilhada</a>
            <a class="btn" id="IluminacaoPublica" onclick="ResetRegions(2);return false" href="#">Iluminação Pública</a>
            <a class="btn" id="PlanoDiretor" onclick="ResetRegions(3);return false" href="#">Plano Diretor</a>
            <a class="btn" id="MobilidadeUrbana" onclick="ResetRegions(4);return false" href="#">Mobilidade Urbana</a>
            <a class="btn" id="DiagnosticoSocioAmbiental" onclick="ResetRegions(5);return false" href="#">Diagnóstico Socioambiental</a>

        </div>




        <div class="" style="clear: both; margin-bottom: 15px;"></div>

        <div id="content" class="content">



            <div id="mapaSc">
                <div id="inner2">
                    <img src="images/RosaDosVentos.png" style="width: 75px" />
                </div>
                <div id="inner1">
                    Municípios Consorciados: <%=TotalMunicipios %>
                    
                </div>
            </div>
        </div>


        <div class="" style="clear: both;"></div>

        <script type="text/javascript">
            var markercolor = "white";
            $("#CorMarcador").spectrum({
                color: markercolor,
                showInput: true,
                className: "full-spectrum",
                showInitial: true,
                showPalette: true,
                showSelectionPalette: true,
                maxSelectionSize: 10,
                preferredFormat: "hex",
                localStorageKey: "spectrum.demo",
                move: function (color) {

                },
                show: function () {

                },
                beforeShow: function () {

                },
                hide: function () {

                },
                change: function (color) {
                    markercolor = color;
                },
                palette: [
                    ["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
                        "rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)"],
                    ["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
                        "rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"],
                    ["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
                        "rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
                        "rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
                        "rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
                        "rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
                        "rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
                        "rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
                        "rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
                        "rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
                        "rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
                ]
            });

        </script>
</body>
</html>
