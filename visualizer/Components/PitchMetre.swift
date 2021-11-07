import SwiftUI

struct PitchMetre: View {
    let position: Int // range: 0-8
    
    var body: some View {
        Rectangle()
            .fill(position == 4 ? Color("bgSuccess") : Color("bgSecondary"))
            .frame(maxWidth: 328, maxHeight: 55)
            .cornerRadius(15)
            .overlay(
                HStack{
                    ForEach(0...3, id: \.self) { i in
                        if(i == position){
                            Circle().frame(width: 10, height: 10).foregroundColor(Color("error")).padding(10)
                        }else{
                            Circle().frame(width: 5, height: 5).foregroundColor(Color("secondary")).padding(10)
                        }
                    }
                    if(position == 4){
                        Circle().frame(width: 14, height: 14).foregroundColor(Color("success")).padding(10)
                    }else{
                        Circle().frame(width: 14, height: 14).foregroundColor(Color("primary")).padding(10)
                    }
                    ForEach(5...8, id: \.self) { j in
                        if(j == position){
                            Circle().frame(width: 10, height: 10).foregroundColor(Color("error")).padding(10)
                        }else{
                            Circle().frame(width: 5, height: 5).foregroundColor(Color("secondary")).padding(10)
                        }
                    }
                }
            )
    }
}

struct PitchMetre_Previews: PreviewProvider {
    static var previews: some View {
        PitchMetre(position: 4)
    }
}
