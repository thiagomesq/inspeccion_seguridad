import 'package:flutter/material.dart';

const eiConsultoriaGreen = Color(0xff75b631);
const eiConsultoriaLightGreen = Color(0xffeee8aa);
const eiConsultoriaBlue = Color(0xff34598d);
const paracelSilver = Color(0xffc0c0c0);
const paracelGreen = Color(0xff013004);
const pdfRed = Color(0xffff120f);
const excelGreen = Color(0xff217346);

const headerNaoConformidadeTable = <DataColumn>[
  DataColumn(
    label: Text(
      'Itens de Verificação',
      style: tableHeaderTextStyle,
    ),
  ),
  DataColumn(
    label: Text(
      'Descrição',
      style: tableHeaderTextStyle,
    ),
  ),
];

const tableHeaderTextStyle = TextStyle(
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
  color: eiConsultoriaGreen,
);

const paginationSelectableRowCount = <int>[
  5,
  10,
  25,
  50,
];

const iconBtnPdf = Icon(
  Icons.picture_as_pdf_rounded,
  color: Colors.white,
);

const textBtnExcel = Text(
  'X',
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white54,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
);
