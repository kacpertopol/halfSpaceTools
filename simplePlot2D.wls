#!/usr/bin/env wolframscript
(* ::Package:: *)

(*path to file -> graphics object*)
parseFile[path_]:= 
Module[{data},
	data = Import[path , "Table"];
	Graphics[Fold[
		Function[{acc,row},
			Which[
				row[[1]] == "pol2D", {Join[acc[[1]] , {RGBColor[acc[[3]][[1;;3]]],Opacity[acc[[3]][[4]]],Polygon@acc[[2]]}],{} , acc[[3]]},
				row[[1]] == "pnt2D" , {acc[[1]] , Join[acc[[2]] , {row[[2;;]]}] , acc[[3]]},
				row[[1]] == "color" , {acc[[1]] , acc[[2]] , row[[2;;]]},
				True , acc
			]
		],
		{{},{},{0.,0.,0.,1.}},
		data
	][[1]] , PlotRange -> All]
];


files = $ScriptCommandLine[[2;;]];
parsed = parseFile[files[[1]]];
If[Length[files] == 2,
	Export[files[[2]],parsed];
];
