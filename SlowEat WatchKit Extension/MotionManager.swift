import CoreMotion
import Foundation
import WatchKit

class MotionManager {

    let motionManager = CMMotionManager()
    let queue = OperationQueue()

    static let sampleInterval = 1.0 / 50
    static let bufferSize = 25
    static let frequency = (1.0 / MotionManager.sampleInterval) / Double(MotionManager.bufferSize)

    let buffer = RunningBuffer(size: MotionManager.bufferSize)

    var sample = 0

    weak var delegate: MovementDelegate?

    init() {
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
    }

    func startUpdates() {
        print("startUpdates")

        if !motionManager.isDeviceMotionAvailable {
            print("Device Motion is not available.")
            return
        }

        resetAllState()

        motionManager.deviceMotionUpdateInterval = MotionManager.sampleInterval
        motionManager.startDeviceMotionUpdates(to: queue) { deviceMotion, error in
            if error != nil {
                print("Encountered error: \(error!)")
            }

            if deviceMotion != nil {
                self.processDeviceMotion(deviceMotion!)
            }
        }
        print("startedUpdates")
    }

    func stopUpdates() {
        print("stopUpdates")

        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
            print("stoppedUpdates")
        } else {
            print("Device Motion is not available.")
        }
    }

    func processDeviceMotion(_ deviceMotion: CMDeviceMotion) {
        let rotation = abs(deviceMotion.rotationRate.x) + abs(deviceMotion.rotationRate.y) + abs(deviceMotion.rotationRate.z)
        let acceleration = abs(deviceMotion.userAcceleration.x) + abs(deviceMotion.userAcceleration.y) + abs(deviceMotion.userAcceleration.z)

        let everything = rotation + acceleration
        buffer.addSample(everything)

        sample += 1

        if sample >= MotionManager.bufferSize {
            sample = 0
            let mean = buffer.recentMean()
            if mean < 1.0 {
                delegate?.waiting()
            } else {
                delegate?.moving()
            }
        }
    }

    func resetAllState() {
        print("resetAllState")
    }
}
