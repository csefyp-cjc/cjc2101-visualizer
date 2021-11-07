import SwiftUI

struct Axes: View {
    @State private var yValues = ["90", "70", "35", "0", "-40"]
    @State private var xValues = ["25", "100", "400", "1000", "2000", "4000"]
    
    var body: some View {
        VStack{
            ForEach(yValues, id: \.self){ value in
                HStack{
                    //TODO: align text above line
                    Rectangle()
                        .fill(Color("axis"))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 2, alignment: .bottom)
                    Text(value).foregroundColor(Color("onAxis")).font(.system(size: 14))
                }.padding(18)
            }
            HStack{
                ForEach(xValues, id: \.self){value in
                    Text(value).foregroundColor(Color("onAxis")).font(.system(size: 14)).frame(maxWidth: .infinity)
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct Axes_Previews: PreviewProvider {
    static var previews: some View {
        Axes()
    }
}
