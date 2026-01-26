import 'checklist_models.dart';
import 'etp_models.dart';

/// Catálogo inicial: aquí defines reportes nuevos sin duplicar UI/PDF.
/// En producción, esto puede venir del backend como JSON y cachearse offline.
class ReportsCatalog {
  static const _manttoSitesItems = <ChecklistItemDefinition>[
    ChecklistItemDefinition(id: 'site_01', label: 'Pintura en muros'),
    ChecklistItemDefinition(id: 'site_02', label: 'Pintura epoxica en piso'),
    ChecklistItemDefinition(id: 'site_03', label: 'Iluminación'),
    ChecklistItemDefinition(id: 'site_04', label: 'Sensor de humo'),
    ChecklistItemDefinition(id: 'site_05', label: 'Cámara de videovigilancia'),
    ChecklistItemDefinition(id: 'site_06', label: 'Control de acceso'),
    ChecklistItemDefinition(id: 'site_07', label: 'Condiciones de plafón'),
    ChecklistItemDefinition(id: 'site_08', label: 'Temperatura interna de CT'),
    ChecklistItemDefinition(id: 'site_09', label: 'Limpieza general del CT'),
    ChecklistItemDefinition(
      id: 'site_10',
      label: 'Objetos, articulos y/o equipos no correspondientes al CT',
    ),
    ChecklistItemDefinition(id: 'site_11', label: 'Comentarios'),
    ChecklistItemDefinition(
      id: 'site_12',
      label: 'Control de acceso frontal por gabinete',
    ),
    ChecklistItemDefinition(
      id: 'site_13',
      label: 'Control de acceso posterior por gabinete',
    ),
    ChecklistItemDefinition(
      id: 'site_14',
      label: 'Temperatura interna de gabinete',
    ),
    ChecklistItemDefinition(id: 'site_15', label: 'Humedad relativa interna'),
    ChecklistItemDefinition(
      id: 'site_16',
      label: 'Sujesión de tuercas enjauladas y tornilleria',
    ),
    ChecklistItemDefinition(id: 'site_17', label: 'Netboz, monitor de rack'),
    ChecklistItemDefinition(id: 'site_18', label: 'Comentarios'),
    ChecklistItemDefinition(id: 'site_19', label: 'Voltaje de entrada UPS01'),
    ChecklistItemDefinition(id: 'site_20', label: 'Voltaje de entrada UPS02'),
    ChecklistItemDefinition(id: 'site_21', label: 'Voltaje de salida UPS01'),
    ChecklistItemDefinition(id: 'site_22', label: 'Voltaje de salida UPS02'),
    ChecklistItemDefinition(
      id: 'site_23',
      label: 'Estado de baterias del UPS01',
    ),
    ChecklistItemDefinition(
      id: 'site_24',
      label: 'Estado de baterias del UPS02',
    ),
    ChecklistItemDefinition(
      id: 'site_25',
      label: 'Funcionamiento del Bypass 01',
    ),
    ChecklistItemDefinition(
      id: 'site_26',
      label: 'Funcionamiento del Bypass 02',
    ),
    ChecklistItemDefinition(id: 'site_27', label: 'Comentarios'),
    ChecklistItemDefinition(
      id: 'site_28',
      label: 'Etiquetado frontal y posterior de gabinete',
    ),
    ChecklistItemDefinition(id: 'site_29', label: 'Golpes o daños'),
    ChecklistItemDefinition(id: 'site_30', label: 'Conexión de TGB a SBB'),
    ChecklistItemDefinition(id: 'site_31', label: 'Etiqueta de barra de TF'),
    ChecklistItemDefinition(id: 'site_32', label: 'Equipos aterrizados'),
    ChecklistItemDefinition(id: 'site_33', label: 'Comentarios'),
    ChecklistItemDefinition(id: 'site_34', label: 'Soporteria ajustada'),
    ChecklistItemDefinition(
      id: 'site_35',
      label: 'Limpieza de escalera Runway',
    ),
    ChecklistItemDefinition(id: 'site_36', label: 'Estado de los accesorios'),
    ChecklistItemDefinition(id: 'site_37', label: 'Sujeción de postes'),
    ChecklistItemDefinition(
      id: 'site_38',
      label: 'Revisión y ajuste de tornilleria en cada unión',
    ),
    ChecklistItemDefinition(
      id: 'site_39',
      label: 'Aterrizado de escalera Runway',
    ),
    ChecklistItemDefinition(id: 'site_40', label: 'Nivelación de escalera'),
    ChecklistItemDefinition(id: 'site_41', label: 'Comentarios'),
    ChecklistItemDefinition(id: 'site_42', label: 'Limpieza de rack'),
    ChecklistItemDefinition(
      id: 'site_43',
      label: 'Sujeción y anclaje de cada rack',
    ),
    ChecklistItemDefinition(
      id: 'site_44',
      label: 'Aterrizado a TF de cada rack',
    ),
    ChecklistItemDefinition(
      id: 'site_45',
      label:
          'Sujeción y ajuste en todos los tornillos de cada accesorio y/o equipo rackeado',
    ),
    ChecklistItemDefinition(
      id: 'site_46',
      label: 'Tapas frontales y traseras de organizadores frontales',
    ),
    ChecklistItemDefinition(
      id: 'site_47',
      label: 'Inspección fisica de la conexión en los paneles de parcheo',
    ),
    ChecklistItemDefinition(
      id: 'site_48',
      label: 'Etiquetado de cada uno de los nodos rematados',
    ),
    ChecklistItemDefinition(id: 'site_49', label: 'Etiquetado de line cord'),
    ChecklistItemDefinition(
      id: 'site_50',
      label: 'Acomodo/peinado del sistema de cableado',
    ),
    ChecklistItemDefinition(
      id: 'site_51',
      label: 'Conexión de los pacht cord a los paneles de parcheo',
    ),
    ChecklistItemDefinition(
      id: 'site_52',
      label: 'Inspeción física de conexión de FO',
    ),
    ChecklistItemDefinition(
      id: 'site_53',
      label: 'Etiquetado de enlaces de FO',
    ),
    ChecklistItemDefinition(
      id: 'site_54',
      label: 'Etiquetado correcto de los jumper',
    ),
    ChecklistItemDefinition(id: 'site_55', label: 'Etiquetado de cada rack'),
    ChecklistItemDefinition(id: 'site_56', label: 'Etiqueta de barra de TF'),
    ChecklistItemDefinition(id: 'site_57', label: 'Conexión de TGB a SBB'),
    ChecklistItemDefinition(
      id: 'site_58',
      label: 'Suministro eléctrico en los contactos del rack',
    ),
    ChecklistItemDefinition(id: 'site_59', label: 'Nivelación de escalera'),
    ChecklistItemDefinition(id: 'site_60', label: 'Comentarios'),
  ];

  static const mantenimientoMostrador = ChecklistReportDefinition(
    id: 'mantto_mostrador',
    title: 'Equipos de mostrador',
    pdfHeaderTitle: 'REPORTE DE MANTENIMIENTO PREVENTIVO',
    locationLabel: 'Mostrador',
    items: [
      ChecklistItemDefinition(id: 'impresora_atb', label: 'Impresora ATB'),
      ChecklistItemDefinition(id: 'impresora_btp', label: 'Impresora BTP'),
      ChecklistItemDefinition(
        id: 'impresora_puntos',
        label: 'Impresora de puntos',
      ),
      ChecklistItemDefinition(
        id: 'lector_documentos',
        label: 'Lector de documentos',
      ),
      ChecklistItemDefinition(
        id: 'lector_pases_abordar',
        label: 'Lector de pases de abordar',
      ),
      ChecklistItemDefinition(id: 'sistema_pava', label: 'Sistema PAVA'),
      ChecklistItemDefinition(id: 'telefono_ip', label: 'Teléfono IP'),
      ChecklistItemDefinition(id: 'monitor', label: 'Monitor'),
      ChecklistItemDefinition(id: 'cpu', label: 'CPU'),
      ChecklistItemDefinition(id: 'teclado', label: 'Teclado'),
      ChecklistItemDefinition(id: 'mouse', label: 'Mouse'),
      ChecklistItemDefinition(id: 'cableado_red', label: 'Cableado de red'),
      ChecklistItemDefinition(id: 'cableado_gral', label: 'Cableado Gral.'),
      ChecklistItemDefinition(
        id: 'limpieza_general_mostrador',
        label: 'Limpieza general del mostrador',
      ),
      ChecklistItemDefinition(
        id: 'comentarios_generales_1',
        label: 'Comentarios generales',
      ),
      ChecklistItemDefinition(
        id: 'voltaje_entrada_nobreak_01',
        label: 'Voltaje de entrada No Breack 01',
      ),
      ChecklistItemDefinition(
        id: 'voltaje_entrada_nobreak_02',
        label: 'Voltaje de entrada No Breack 02',
      ),
      ChecklistItemDefinition(
        id: 'voltaje_salida_contactos_regulado',
        label: 'Voltaje de salida en contactos regulado',
      ),
      ChecklistItemDefinition(
        id: 'estado_baterias_ups_01',
        label: 'Estado de baterias del UPS 01',
      ),
      ChecklistItemDefinition(
        id: 'estado_baterias_ups_02',
        label: 'Estado de baterias del UPS 02',
      ),
      ChecklistItemDefinition(
        id: 'comentarios_generales_2',
        label: 'Comentarios generales',
      ),
    ],
  );

  static const mantenimientoSites = ChecklistReportDefinition(
    id: 'mantto_sites',
    title: 'Equipos de site',
    pdfHeaderTitle: 'REPORTE DE MANTENIMIENTO PREVENTIVO',
    locationLabel: 'Site',
    items: _manttoSitesItems,
  );

  static const checklistEtp = EtpChecklistDefinition(
    id: 'cl_etp',
    title: 'Check List Diario de Sistemas y Equipos TIC´S',
    pdfHeaderTitle: 'CHECK LIST DIARIO DE SISTEMAS Y EQUIPOS TIC´S',
    items: [
      EtpChecklistItemDefinition(
        id: 'videowalls',
        label: 'Videowalls y pantallas',
      ),
      EtpChecklistItemDefinition(id: 'telefonia_ip', label: 'Teléfonia IP'),
      EtpChecklistItemDefinition(id: 'pava', label: 'Pava'),
      EtpChecklistItemDefinition(
        id: 'equipo_computo',
        label: 'Equipo de computo',
      ),
      EtpChecklistItemDefinition(
        id: 'imp_xerox_epson',
        label: 'Imp.Xerox/Epson',
      ),
      EtpChecklistItemDefinition(id: 'fids', label: 'Fids'),
      EtpChecklistItemDefinition(id: 'cupps', label: 'CUPPS'),
      EtpChecklistItemDefinition(
        id: 'radiocomunicacion',
        label: 'Radiocomunicación',
      ),
      EtpChecklistItemDefinition(
        id: 'sistemas_aeroportuarios',
        label: 'Sistemas aeroportuarios',
      ),
      EtpChecklistItemDefinition(id: 'wifi', label: 'Wifi'),
      EtpChecklistItemDefinition(id: 'egate', label: 'E-gate'),
      EtpChecklistItemDefinition(id: 'telefono_rojo', label: 'Telefono rojo'),
      EtpChecklistItemDefinition(
        id: 'videovigilancia',
        label: 'Videovigilancia',
      ),
      EtpChecklistItemDefinition(id: 'kioscos', label: 'Kioscos'),
      EtpChecklistItemDefinition(id: 'grp', label: 'GRP'),
      EtpChecklistItemDefinition(
        id: 'equipo_activo_red',
        label: 'Equipo activo de red',
      ),
    ],
  );
}
