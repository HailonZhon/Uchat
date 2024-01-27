//import SwiftUI
//
//struct ContentView: View {
//    @State private var isDrawerOpen: Bool = false
//    let drawerWidth: CGFloat = UIScreen.main.bounds.width * 2 / 3
//    
//    var body: some View {
//        let drag = DragGesture()
//            .onEnded {
//                if $0.translation.width > 100 {
//                    // 如果向右拖动距离超过100，则打开抽屉
//                    withAnimation {
//                        self.isDrawerOpen = true
//                    }
//                } else if $0.translation.width < -100 {
//                    // 如果向左拖动距离超过100，则关闭抽屉
//                    withAnimation {
//                        self.isDrawerOpen = false
//                    }
//                }
//            }
//
//        return GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                MainPageView(isDrawerOpen: self.$isDrawerOpen)
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .offset(x: self.isDrawerOpen ? self.drawerWidth : 0)
//                    .disabled(self.isDrawerOpen)
//                    .gesture(drag)
//                
//                if self.isDrawerOpen {
//                    DrawerView()
//                        .frame(width: self.drawerWidth)
//                        .transition(.move(edge: .leading))
//                }
//            }
//        }
//    }
//}
//
//struct MainPageView: View {
//    @Binding var isDrawerOpen: Bool
//    
//    var body: some View {
//        // 主页面内容
//        VStack {
//            Button(action: {
//                withAnimation {
//                    self.isDrawerOpen.toggle()
//                }
//            }) {
//                Image(systemName: "line.horizontal.3")
//                    .imageScale(.large)
//                    .foregroundColor(.black)
//            }
//            .padding()
//            // 其他内容...
//        }
//    }
//}
//
//struct DrawerView: View {
//    var body: some View {
//        VStack {
//            // 抽屉视图内容...
//            Text("侧边栏内容")
//            Spacer()
//        }
//        .background(Color.gray.opacity(0.5))
//    }
//}
