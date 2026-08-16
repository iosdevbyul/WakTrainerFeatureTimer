import SwiftUI
import WakTrainerCoreModels

public struct RetroTimerView: View {
    @State private var hours = 12
    @State private var minutes = 0
    @State private var seconds = 59
    @State private var timerActive = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    public init() {}

    public var body: some View {
        VStack(spacing: 30) {
            VStack {
                HStack {
                    Text("SwiftUI")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("T-100")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding([.horizontal, .top], 20)

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.8, green: 0.82, blue: 0.8))
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                .blur(radius: 1)
                                .offset(x: 1, y: 1)
                                .mask(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                        )

                    HStack(alignment: .bottom, spacing: 2) {
                        Text(String(format: "%02d:%02d", hours, minutes))
                            .font(.system(size: 80, weight: .black, design: .monospaced))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                        
                        Text(String(format: "%02d", seconds))
                            .font(.system(size: 45, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .padding(.bottom, 10)
                    }
                }
                .padding(.horizontal, 15)

                HStack(spacing: 20) {
                    Group {
                        CircleButton(text: "H")
                        CircleButton(text: "M")
                        CircleButton(text: "CLR")
                    }

                    Spacer()

                    Button(action: {
                        timerActive.toggle()
                    }) {
                        Capsule()
                            .fill(Color.white)
                            .frame(width: 120, height: 50)
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .overlay(
                                Text(timerActive ? "STOP" : "START")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(timerActive ? .red : .blue)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 2, y: 2)
                    }
                }
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 10)
            }
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .frame(width: 380)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.95, green: 0.95, blue: 0.97))
        .onReceive(timer) { _ in
            if timerActive {
                performTimerTick()
            }
        }
    }
    
    private func performTimerTick() {
        if seconds > 0 {
            seconds -= 1
        } else {
            if minutes > 0 {
                minutes -= 1
                seconds = 59
            } else {
                if hours > 0 {
                    hours -= 1
                    minutes = 59
                    seconds = 59
                } else {
                    timerActive = false
                }
            }
        }
    }
}

struct CircleButton: View {
    var text: String
    
    var body: some View {
        Button(action: {}) {
            Circle()
                .fill(Color.white)
                .frame(width: 50, height: 50)
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .overlay(
                    Text(text)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
        }
    }
}
