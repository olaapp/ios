//
//  K.swift
//  AESApp
//
//  Created by Alex on 4/30/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


// MARK: -Constants
struct K {
    
    //Default images
    static let defaultImage1 = "https://firebasestorage.googleapis.com/v0/b/aes-app-755d2.appspot.com/o/icons%2Fportada-nino.1280x0_500x400.jpg?alt=media&token=5d2afb7e-07c2-435f-a95c-6b5db2273ecd"
    static let defaultProfileImage = "https://firebasestorage.googleapis.com/v0/b/aes-app-755d2.appspot.com/o/bad-profile-pic-2-768x768.jpeg?alt=media&token=c23dd144-af68-401b-b573-ae642b3c7bc0"
    
    //Keys
    static let gmsServices = "AIzaSyCmUZ92zabfgDJ2LXXk0vuB03h4PxJsG_k"
    static let oneSignal = "22707d48-228e-4b9c-910a-b61fb4045af9"
    static let oneSignal2 = "56c8702e-f968-4700-b638-c1a7cc123ab3"
    
    //URL
    static let chatURL = "http://www.aes-elsalvador.com/site/webchat.html"
    
    // MARK:- Segues from storyboards
    struct segues {
        
        static let showAlert = "ShowAlert"
        
        struct main {
            static let mainControllerToSignIn = "MainControllerToSignIn"
        }
        
        struct auth {
            static let typeNumberToNumberCodeController = "TypeNumberToNumberCodeController"
            static let siginInToMainController = "SiginInToMainController"
        }
        
        struct news {
            static let listNewsControllerToNewsDetailController = "ListNewsControllerToNewsDetailController"
        }
        
        struct consultation {
            static let consultationToSignInAlert = "ConsultationToSignInAlert"
            static let consultationControllerToOffices = "ConsultationControllerToOffices"
            static let consultationControllerToPermission = "ConsultationControllerToPermission"
            static let consultationControllerToScheduledOutages = "ConsultationControllerToScheduledOutages"
            static let consultationControllerToCalculator = "ConsultationControllerToCalculator"
            static let consultationControllerToProfile = "ConsultationControllerToProfile"
            static let consultationControllerToNewsDetail = "ConsultationControllerToNewsDetail"
            static let consultationControllerToNewsWebview = "ConsultationControllerToNewsWebview"
            static let consultationControllerToListNews = "ConsultationControllerToListNews"
            static let consultationControllerToComplaints = "ConsultationControllerToComplaints"
            static let consultationControllerToHazardReports = "ConsultationControllerToHazardReports"
            static let consultationControllerToInnovation = "ConsultationControllerToInnovation"
            static let consultationToNotificationWebView = "ConsultationToNotificationWebView"
        }
        
        struct managements {
            static let managementsToComplaintsController = "ManagementsToComplaintsController"
            static let managementsControllerToScheduledOutages = "ManagementsControllerToScheduledOutages"
            static let managementsControllerToHazardReports = "ManagementsControllerToHazardReports"
            static let managementsToSignInAlert = "ManagementsToSignInAlert"
            static let managementsToCalculator = "ManagementsToCalculator"
            static let managementsControllerToProfile = "ManagementsControllerToProfile"
            static let managementsControllerToBills = "ManagementsControllerToBills"
            static let managementsControllerToManagementsAccounts = "ManagementsControllerToManagementsAccounts"
            static let managementsToConsumptions = "ManagementsToConsumptions"
            
            static let managementsToAppointments = "ManagementsToAppointments"
            static let managementsToNewservices = "ManagementsToNewServices"
            static let showWelcomeController = "ShowWelcomeController"
            
        }
        
        struct offices {
            static let officeControllerToOfficeDetail = "OfficeControllerToOfficeDetail"
            static let addressDetailControllerToNewReservation = "AddressDetailControllerToNewReservation"
            static let officesControllerToPermission = "OfficesControllerToPermission"
        }
        
        struct reservations{
            static let reservationControllerToOfficeDetail = "ReservationControllerToOfficeDetail"
        }
        
        struct complaints {
            static let complaintsControllerToPermission = "ComplaintsControllerToPermission"
            static let complaintsControllerToEditDetailsComplaint = "ComplaintsControllerToEditDetailsComplaint"
            static let listComplaintsControllerToDetails = "ListComplaintsControllerToDetails"
            static let complaintsControllerToDetails = "ComplaintsControllerToDetails"
            static let listComplaintsControllerToComplaints = "ListComplaintsControllerToComplaints"
        }
        
        struct innovation {
            static let listInnovationControllerToInnovation = "ListInnovationControllerToInnovation"
            static let innovationListToDetail = "InnovationListToDetail"
            static let innovationToDetail = "InnovationToDetail"
        }
        
        
        struct outages {
            static let scheduledOutagesControllerToOutagesDetail = "ScheduledOutagesControllerToOutagesDetail"
            static let scheduledOutagesControllerToSetNic = "ScheduledOutagesControllerToSetNic"
        }
        
        struct hazards {
            static let listHazardsReportsControllerToDetails = "ListHazardsReportsControllerToDetails"
            static let hazardsReportsControllerToDetails = "HazardsReportsControllerToDetails"
            static let hazardReportControllerToDetails = "HazardReportControllerToDetails"
        }
        
        struct appointments {
            static let appointmentsControllerToDetail = "AppointmentsControllerToDetail"
        }
        
        struct bills {
            static let billDetailControllerToSetNic = "BillDetailControllerToSetNic"
            static let billDetailToBillWebViewController = "BillDetailToBillWebViewController"
            static let billDetailToPaymentWebViewController = "BillDetailToPaymentWebViewController"
        }
        
        struct profile {
            static let signOutSegue = "SignOutSegue"
        }
        
        
        struct newServices {
            static let getNewServiceToGetNewServiceDetail = "GetNewServiceToGetNewServiceDetail"
            static let listNewServicesControllerToDetails = "ListNewServicesControllerToDetails"
            
        }
        
    }
    
    // MARK:- Cells for TableView and collectionview
    struct cellsIdentifiers {
        
        struct table {
            static let servicesTableCell = "ServicesTableCell"
            static let registerServicesTableCell = "RegisterServicesTableCell"
            static let complaintsTableCell = "ComplaintsTableCell"
            static let scheduledOutagesTableCell = "ScheduledOutagesTableCell"
            static let hazardReportsTableCell = "HazardReportsTableCell"
            static let failureReportsTableCell = "FailureReportsTableCell"
            static let profileTableCell = "ProfileTableCell"
            static let innovationTableCell = "InnovationTableCell"
            static let billsTableCell = "BillsTableCell"
            static let newsTableCell = "NewsTableCell"
            static let newServicesTableCell = "NewServicesTableCell"
            static let paymentTableCell = "PaymentTableCell"
            static let notificationTableCell = "NotificationTableCell"
            static let managementsAccountCell = "ManagementsAccountCell"
        
        }
        
        struct collection {
            static let informationCollectionCell = "InformationCollectionCell"
            static let addressCollectionCell = "AddressCollectionCell"
            static let addEvidenceCollectionCell = "AddEvidenceCollectionCell"
            static let appointmentsCollectionCell = "AppointmentsCollectionCell"
            static let hoursCollectionCell = "HoursCollectionCell"
            static let calculatorCollectionCell = "CalculatorCollectionCell"
        }
        
        struct dropDown {
            static let FilterDropDownCell = "FilterDropDownCell"
        }
        
    }
    
    
    // MARK:- DefaultKeys
    struct defaultKeys {
        struct auth {
            static let signIn = "signinset"
            static let token = "token"
            static let fcmToken = "fcmtoken"
        }
        
        struct others {
            static let tutorial = "tutorialset"
            static let departamentos = "departamentosset"
            static let municipios = "municipiosset"
            static let transactions = "transactionsset"
            static let appOptions = "appoptionssset"
            static let names = "namesset"
            static let email = "emailset"
            static let lastNames = "lastNamessset"
            static let setNewServices = "setNewServices"
            static let setWelcome = "setWelcome"
            static let setPhone = "setPhone"
            static let setCalculatorValue = "setCalculatorValue"
            static let setDocumentsNewServices = "setDocumentsNewServices"
            static let setStatusNewServices = "setStatusNewServices"
            
        }
        
        struct consultation {
            static let isPresented = "consultationIsPresented"
            static let news = "consultationNews"
        }
        
        
        struct switchValues {
            static let switch1 = "switch1"
            static let switch2 = "switch2"
            static let switch3 = "switch3"
            static let switch4 = "switch4"
            static let switch5 = "switch5"
            static let switch6 = "switch6"
            
        }
        
        
    }
    
    // MARK:- Storyboards
    struct storyboards {
        static let auth = "Auth"
        static let menu = "Menu"
        static let consultation = "Consultation"
        static let managements = "Managements"
        static let complaints = "Complaints"
        static let chat = "Chat"
        static let news = "News"
        static let hazardReports = "HazardReports"
        static let calculator = "Calculator"
        static let bills = "Bills"
        static let notifications = "Notifications"
    }
    
    
    // MARK:- Instances - Controllers
    struct instances {
        static let mainTabBarController = "MainTabBarController"
        static let consultationController = "ConsultationController"
        static let managementsController = "ManagementsController"
        static let signInController = "SignInController"
        static let complaintsController = "ComplaintsController"
        static let chatController = "ChatController"
        static let listNewslController = "ListNewslController"
        static let paymentWebViewController = "PaymentWebViewController"
        static let listBillsController = "ListBillsController"
        static let notiticationsController = "NotiticationsController"
        static let notificationWebViewController = "NotificationWebViewController"
    }
    
    
    // MARK:- Titles, subtitles, rawtext
    struct titles {
        static let textConfirmAlert = "Aceptar"
        static let textCancelAlert = "Cancelar"
        static let alertWrongTitle = "Sucedio algo:"
        static let alertSuccessTitle = "Hecho"
        static let sendReport = "ENVIAR REPORTE"
        static let reservation = "CONFIRMACIÓN DE CITA"
        static let editButton = "Toca para editar"
        static let selectImage = "Seleccionar una imagen"
        static let selectDocument = "Seleccionar documento"
        
        struct tabbar {
            static let item1 = "Paseos"
        }
        
        struct recoveryButton {
            static let text1 = "Recuperar "
            static let text2 = "contraseña"
        }
        
        struct retryButton {
            static let text1 = "Enviar código "
            static let text2 = "nuevamente"
        }
        
        struct codeButton {
            static let text1 = "Recuperar "
            static let text2 = "contraseña"
        }
        
        struct InformationMenu {
            static let item1 = "Agencias y puntos de pago"
            static let item2 = "Noticias"
            static let item3 = "Interrupciones programadas"
            static let item4 = "Denuncias de hurto"
            static let item5 = "Reporte de peligros en la red"
            static let item6 = "Sugerencias e Innovación"
            
            
            static let item7 = "Perfil de usuario"
            static let item8 = "Consulta y pago de facturas"
            static let item9 = "Gestiones de cuenta"
            static let item10 = "Consumo en línea"
            static let item11 = "Calculadora de consumo"
            static let item12 = "Citas en oficinas comerciales"
            static let item13 = "Solicitud de servicio nuevo"
            
        }
        
        
    }
    
    struct messages {
        static let textLabelEmail = "Correo electrónico"
        static let textLabelPassword = "Contraseña"
        static let textNumberPhone = "Número telefónico"
        static let textNumberCode = "Código de validación"
        static let textLabelNIC = "NIC"
        static let textLabelSearchNIC = "Buscar por NIC"
        static let textLabelLastBill = "NÚMERO DE ÚLTIMA FACTURA"
        static let textNIC  = "Ingresa el número NIC"
        static let textLastBill = "Última factura recibida"
        static let textLabelCustomName = "Nombre personalizado"
        static let textBornDate = "Fecha de nacimiento"
        static let textNames = "Nombres"
        static let textLastNames = "Apellidos"
        static let textStartDate = "Fecha de inicio"
        static let textEndDate = "Fecha fin"
        static let textCustomName = "Por ejemplo: Casa 1"
        static let textHistoricalEmail = "Correo electrónico para recibir el historial"
        
        static let noInternet = "Es necesario verificar la conexión a Internet"
        static let emptyEmail = "Favor ingresar correo electrónico"
        static let badEmail = "Favor ingresar correo electrónico válido"
        static let emptyPassword = "Favor ingresar su contraseña"
        static let wrongPassword = "La contraseña que ingresó no es correcta"
        static let weakPassword = "La contraseña que ingresó no cumple los parámetros"
        static let selectAssets = "No ha seleccionado ningún archivo"
        static let commentEmpty = "Debes colocar tu comentario"
        static let startEmpty = "No ha seleccionado una fecha de inicio"
        static let endEmpty = "No ha seleccionado una fecha fin"
        static let added = "Agregado con éxito"
        static let notaAdded = "Debe revisar los datos ingresados"
        static let reservationAuth = "Para realizar una reservación debe iniciar sesión"
        static let issue = "No fue posible obtener datos"
        static let passwordUpdated = "Recibirá un correo electrónico con un link para gestionar su contraseña"
        static let passwordUpdatedWrong = "No fue posible gestionar su contraseña, vuelva a intentar"
        static let dropDownEmpty = "No fue posible cargar"
        static let shouldSelectDropDown = "Debe seleccionar una categoría"
        
        static let sureImages = "¿Desea enviar un reporte sin adjuntar fotografías?"
        static let authBiometricIssue = "No fue posible identificar"
        
        static let innovation = "Gracias por tu aporte, tu idea fue recibida"
        static let theft = "Tu reporte ha sido enviado"
        static let nic = "Todavía no has agregado NICs a tu cuenta"
        static let reservation = "Tu cita fue creada con éxito, el numero de referencia es: "
        static let newService = "Solicitud enviada con éxito"
        
        static let facebookIssue = "No fue posible acceder a Facebook"
        
        static let alreadyComplaint = "Existe un reclamo del mismo tipo sin cerrar"
        static let noNicData = "No hay datos para el NIC N"
        static let noMachines = "Debes seleccionar al menos 1 aparato"
        static let noTypeSelectednewServices = "Debes seleccionar tipo servicio y tipo de conexión"
        
        static let messageSelectDocument = "Seleccione una opción:"
        
        static let photosIssueUploads = "Una o más fotografías no pudieron ser cargadas"
        static let documentIssueUploads = "Una o más documentos no pudieron ser cargados"
        
    }
    
    struct placeholder {
        static let typePhoneNumber = "Ingresa tu número telefónico"
        static let typeCodeNumber = "Ingresa tu código"
    }
    
    // MARK:- Utils and others
    struct colors {
        static let selectedImageCanType = "#879CA5"
    }
    
    struct NIB {
        static let alertMessage = "AlertMessage"
        static let alertMapsDialog = "AlertMapsDialog"
        static let customNameAlert = "CustomNameAlert"
        static let filterDialog = "FIlterAlert"
        static let profileEditInfoAlert = "ProfileEditInfoAlert"
        static let consumptionAlert = "ConsumptionAlert"
        static let paymentAlert = "PaymentAlert"
        static let managementFirstAlert = "ManagementFirstAlert"
        static let managementSecondAlert = "ManagementSecondAlert"
        static let managementThirdAlert = "ManagementThirdAlert"
        static let managementFourthAlert = "ManagementFourthAlert"
        static let managementFifthAlert = "ManagementFifthAlert"
        static let supplyNotServiceAlert = "SupplyNotServiceAlert"
        static let calculatorAlert = "CalculatorAlert"
        static let newServicesAlert = "NewServicesAlert"
        static let newServicesAlert2 = "NewServicesAlert2"
        static let newServicesAlert3 = "NewServicesAlert3"
        static let notificationPushDialog = "NotificationPushDialog"
    }
    
    struct others {
        static let dateFormat =  "dd MMMM yyyy"
        static let ZO443 = "Zona sin Servicio"
    }
    
    struct font {
        static let fontRegular = "Montserrat-Regular"
        static let fontBold = "Montserrat-Bold"
    }
    
    struct animations {
        static let squeezeDown = "squeezeDown"
    }
    
    struct assets {
        static let button_a = "button_a"
    }
    
    struct files {
        static let mapstyle = "mapstyle"
        static let profileLottie = "profile"
    }
    
    struct fileType {
        static let JSON = "json"
    }
    
    
    struct eventsCode{
        static let home_screen = "HomeScreen"
        static let managaments_screen = "ManagamentsScreen"
        static let offices = "Offices"
        static let news = "News"
        static let theft = "Theft"
        static let outstages = "Outstages"
        static let hazardReports = "HazardReports"
        static let innovation = "Innovation"
        
    }
    
    struct eventsName{
        static let homeScreen = "home_screen"
        static let managamentsScreen  = "managaments_screen"
        static let officesScreen = "offices _screen"
        static let newsScreen = "news_screen"
        static let theftScreen = "theft_screen"
        static let outstagesScreen = "outstages_screen"
        static let hazardReportsScreen = "hazardReports_screen"
        static let innovationScreen = "innovation_screen"
        
        
        static let managamentAccountScreen = "ManagamentAccountScreen"
        
        
    }
    
    struct mgCodes{
        struct Attention {
            static let ZO153 = "ZO153"
            static let ZO154 = "ZO154"
            static let ZO214 = "ZO214"
        }
        
        struct Complaint {
            static let ZO011 = "ZO011"
        }
        
        struct Historical {
            static let ZO476 = "ZO476"
            static let ZO477 = "ZO477"
        }
        
        struct Report {
            static let ZO150 = "ZO150"
            static let ZO400 = "ZO400"
            static let ZO443 = "ZO443"
        }
        
    }
    

    
}



// MARK: -ENUM
enum TextFieldText {
   
    case email
    case password
    case phoneNumber
    case code
    case NIC
    case searchNIC
    case lastBill
    case customName
    case bornDate
    case names
    case lastnames
    case startDate
    case endDate
    case historicalEmail
    
    var label: String {
        switch self {
        case .email: return K.messages.textLabelEmail
        case .password: return K.messages.textLabelPassword
        case .phoneNumber: return K.messages.textNumberPhone
        case .code: return K.messages.textNumberCode
        case .NIC: return K.messages.textLabelNIC
        case .searchNIC: return K.messages.textLabelSearchNIC
        case .lastBill: return K.messages.textLabelLastBill
        case .customName: return K.messages.textLabelCustomName
        case .bornDate: return K.messages.textBornDate
        case .names: return K.messages.textNames
        case .lastnames: return K.messages.textLastNames
        case .startDate: return K.messages.textStartDate
        case .endDate: return K.messages.textEndDate
        case .historicalEmail: return K.messages.textHistoricalEmail
        }
    }
}





enum AuthRequired{
    case email
    case fb
    case google
}

enum AuthMessages{
    case done
    case doneRegisted
    case notRegistered
    
    
    var message: String{
        switch self {
        
        case .done: return "Successfully logged in."
        case .doneRegisted: return "Successfully registered."
        case .notRegistered: return "User does not exist."
        
        }
    }
}

enum ResponseMessages{
    case success
    case successQuery
    case doneCalculated
    case doneRegistered
    case updated
    case executed
    
    var message: String{
        switch self {
        
        case .success: return "Query completed"
        case .successQuery: return "query completed"
        case .doneCalculated: return "Successfully calculated."
        case .doneRegistered: return "Successfully registered."
        case .updated: return "Successfully updated."
        case .executed: return "Servicio ejecutado con éxito"
        }
    }
}


enum Departamentos{
    
    case Ahuachapán
    case Cabanas
    case Chalatenango
    case Cuscatlán
    case LaLibertad
    case LaPaz
    case LaUnion
    case Morazán
    case SanMiguel
    case SanSalvador
    case SantaAna
    case SanVicente
    case Sonsonate
    case Usulután
    
    
    var departamento: String{
        switch self {
        case .Ahuachapán: return "Ahuachapán"
        case .Cabanas: return "Cabañas"
        case .Chalatenango: return "Chalatenango"
        case .Cuscatlán: return "Cuscatlán"
        case .LaLibertad: return "La Libertad"
        case .LaPaz: return "La Paz"
        case .LaUnion: return "La Union"
        case .Morazán: return "Morazán"
        case .SanMiguel: return "San Miguel"
        case .SanSalvador: return "San Salvador"
        case .SantaAna: return "Santa Ana"
        case .SanVicente: return "San Vicente"
        case .Sonsonate: return "San Vicente"
        case .Usulután: return "Usulután"
        }
    }
}



enum reasons {
    case LineaDirecta
    case MedidorDanado
    case MedidorSuciedadQuebrado
    case ServicioConectadoDirecto
    case SoldadorConectado
    case ManipulacionMedidor
    case Otros
    
    var message: ReasonsModel{
        switch self {
        
        case .LineaDirecta: return ReasonsModel(name: "Línea directa", id: 1)
        case .MedidorDanado: return ReasonsModel(name: "Medidor dañado", id: 2)
        case .MedidorSuciedadQuebrado: return ReasonsModel(name: "Medidor con suciedad o quebrado", id: 3)
        case .ServicioConectadoDirecto: return ReasonsModel(name: "Servicio conectado directo", id: 4)
        case .SoldadorConectado: return ReasonsModel(name: "Soldador conectado", id: 5)
        case .ManipulacionMedidor:  return ReasonsModel(name: "Manipulación de medidor", id: 6)
        case .Otros: return ReasonsModel(name: "Otros", id: 7)
            
        @unknown default:
            return ReasonsModel(name: "Línea directa", id: 1)
        }
    }
}



enum schedule {
    case Manana
    case Tarde
    case Noche
    case Permanente
    
    var data: ReasonsModel{
        switch self {
        
        case .Manana: return ReasonsModel(name: "Mañana", id: 1)
        case .Tarde: return ReasonsModel(name: "Tarde", id: 2)
        case .Noche: return ReasonsModel(name: "Noche", id: 3)
        case .Permanente: return ReasonsModel(name: "Permanente", id: 4)
        @unknown default:
            return ReasonsModel(name: "Permanente", id: 4)
        }
    }
}



enum reasonHazard {
    case DanioEnTransformador
    case LineasEnElSuelo
    case VariacionesDeVoltaje
    case DaniosRetenida
    case DaniosEnAcometida
    case LineaRota
    case PosteChocado
    case ConatoDeIncendio
    case LineasElectricasBajas
    case LineasCortocircuitadas
    case FalsoContacto
    case PosteDesplomado
    case PosteLavadoDeLaBase
    case FallasEnAlumbradoPublico
    
    var message: ReasonsModel{
        switch self {
        
        case .DanioEnTransformador: return ReasonsModel(name: "Daño En Transformador", id: 1)
        case .LineasEnElSuelo: return ReasonsModel(name: "Líneas En El Suelo", id: 2)
        case .VariacionesDeVoltaje: return ReasonsModel(name: "Variaciones De Voltaje", id: 3)
        case .DaniosRetenida: return ReasonsModel(name: "Daños Retenida", id: 4)
        case .DaniosEnAcometida: return ReasonsModel(name: "Daños En Acometida", id: 5)
        case .LineaRota: return ReasonsModel(name: "Línea Rota", id: 6)
        case .PosteChocado: return ReasonsModel(name: "Poste Chocado", id: 7)
        case .ConatoDeIncendio: return ReasonsModel(name: "Conato De Incendio", id: 8)
        case .LineasElectricasBajas: return ReasonsModel(name: "Líneas Electricas Bajas", id: 9)
        case .LineasCortocircuitadas: return ReasonsModel(name: "Líneas Cortocircuitadas", id: 10)
        case .FalsoContacto: return ReasonsModel(name: "Falso Contacto", id: 11)
        case .PosteDesplomado: return ReasonsModel(name: "Poste Desplomado", id: 12)
        case .PosteLavadoDeLaBase: return ReasonsModel(name: "Poste Lavado De La Base", id: 13)
        case .FallasEnAlumbradoPublico: return ReasonsModel(name: "Fallas En Alumbrado Publico", id: 14)
        @unknown default:
            return ReasonsModel(name: "Daño En Transformador", id: 1)
        }
    }
}


enum managamentsCategories {
    case Attention
    case Complaint
    case Historic
    case Supply
    
    var data: ReasonsModel{
        switch self {
        
        case .Attention: return ReasonsModel(name: "Incidentes en la Atención", id: 1)
        case .Complaint: return ReasonsModel(name: "Gestiones de Reclamo", id: 2)
        case .Historic: return ReasonsModel(name: "Solicitud de historicos", id: 3)
        case .Supply: return ReasonsModel(name: "Reportes de incidentes con mi suministro", id: 4)
        @unknown default:
            return ReasonsModel(name: "Incidentes en la Atención", id: 1)
        }
    }
}


enum Lotties: String{
    case profile = "profile"
    case notification = "notification"
    case notification2 = "notification2"
}

enum Categories: String{
    case attention = "ATENCION"
    case complaint = "RECLAMO"
    case request = "SOLICITUD"
    case supply = "SUMINISTRO"
}



enum NewServicesTitlesTextField:String{
    
    case title1 = "Nombres"
    case title2 = "Primer apellido"
    case title3 = "Segundo apellido"
    case title5 = "Domicilio"
    case title6 = "Número documento"
    case title7 = "NIT"
    case title8 = "Titular"
    case title9 = "Telefono fijo"
    case title10 = "Telefono celular"
    case title11 = "FAX"
    case title12 = "Correo electrónico"
    case title13 = "No. Registro"
    case title14 = "Profesión/Oficio"
        
}


enum NewServicesTitlesDropdown:String{
    
    case title1 = "Tipo documento"
    case title2 = "Condición fiscal"
        
}


enum field:String{
    case lr_names = "lr_names"
    case lr_lastname = "lr_lastname"
    case lr_slastname = "lr_slastname"
    case lr_profession = "lr_profession"
    case lr_adress = "lr_adress"
    case lr_doc_type = "lr_doc_type"
    case lr_doc_number = "lr_doc_number"
    case lr_nit  = "lr_nit"
    case holder_names = "holder_names"
    case holder_lastname = "holder_lastname"
    case holder_slastname = "holder_slastname"
    case holder_profession = "holder_profession"
    case holder_adress = "holder_adress"
    case holder_doc_type = "holder_doc_type"
    case holder_doc_number = "holder_doc_number"
    case holder_nit = "holder_nit"
    case holder_phone = "holder_phone"
    case holder_mobile = "holder_mobile"
    case holder_fax = "holder_fax"
    case holder_email = "holder_email"
    case holder_fiscal_status = "holder_fiscal_status"
    case holder_fiscal_number = "fiscal_number"
    case holder_type = "holder_type"
    
    case url_doc_1 = "url_doc_1"
    case url_doc_2 = "url_doc_2"
    case url_doc_3 = "url_doc_3"
    case url_doc_4 = "url_doc_4"
    
}
