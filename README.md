# 🇨🇴 Colombia Open Data - Flutter App

## Descripción
Aplicación Flutter que consume la API pública de Colombia (https://api-colombia.com) para mostrar información sobre los datos abiertos del país.

## Endpoints utilizados
| Endpoint | Descripción | URL |
|----------|-------------|-----|
| /Department | Departamentos de Colombia | https://api-colombia.com/api/v1/Department |
| /President | Presidentes de Colombia | https://api-colombia.com/api/v1/President |
| /Region | Regiones naturales | https://api-colombia.com/api/v1/Region |
| /TouristicAttraction | Atractivos turísticos | https://api-colombia.com/api/v1/TouristicAttraction |
| /Holiday/{year} | Festivos por año | https://api-colombia.com/api/v1/Holiday/2024 |

## Arquitectura del proyecto
lib/
├── config/          # Variables de entorno (dotenv)
├── models/          # Modelos con fromJson/toJson
├── routes/          # Configuración de go_router
├── services/        # Llamadas HTTP con manejo de errores
├── themes/          # Tema global con colores de Colombia
├── views/           # Pantallas: Dashboard, Listado, Detalle
└── widgets/         # Componentes reutilizables

## Paquetes utilizados
- `http` ^1.2.1 — Consumo de API REST
- `go_router` ^14.2.0 — Navegación declarativa
- `flutter_dotenv` ^5.1.0 — Variables de entorno
- `shimmer` ^3.0.0 — Efecto de carga

## Rutas implementadas con go_router
| Nombre | Path | Parámetros | Descripción |
|--------|------|-----------|-------------|
| dashboard | / | - | Pantalla principal con cards |
| departments | /departments | - | Listado de departamentos |
| department-detail | /departments/:id | id (int) | Detalle de departamento |
| presidents | /presidents | - | Listado de presidentes |
| president-detail | /presidents/:id | id (int) | Detalle de presidente |
| regions | /regions | - | Listado de regiones |
| region-detail | /regions/:id | id (int) | Detalle de región |
| touristic-attractions | /touristic-attractions | - | Listado de atractivos |
| touristic-attraction-detail | /touristic-attractions/:id | id (int) | Detalle de atractivo |
| holidays | /holidays | - | Festivos del año seleccionado |

## Ejemplo JSON de respuesta - Department
```json
[
  {
    "id": 1,
    "name": "Amazonas",
    "description": "Departamento colombiano ubicado al sur del país",
    "regionId": 5,
    "surface": "109665",
    "population": 76243,
    "phonePrefix": "+578",
    "postalCode": "910001"
  }
]
```

## Manejo de estados
- **Loading**: Efecto shimmer mientras carga
- **Success**: ListView.builder con datos
- **Error**: Widget de error con botón reintentar
