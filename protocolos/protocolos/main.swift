
protocol AdvanceLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    
    var delegate: AdvanceLifeSupport?
    
    func assessSituation() {
        print("Can you tell me what happened??")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
}

struct Paramedic: AdvanceLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("Performs CPR")
    }
    
    
}

let emilio = EmergencyCallHandler()
let pete = Paramedic(handler: emilio)

emilio.medicalEmergency() 
