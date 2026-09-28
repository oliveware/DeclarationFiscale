//
//  FieldComparator.swift
//  DeclarationFiscale
//
//  Created by Herve Crespel on 27/09/2026.
//
import SwiftUI

struct FieldComparator: View {
    let key: String
    let label: String
    @Binding var value: String
    var previous:String?
    var real:String?
    @State var chooseprevious : Bool = false
    @State var choosereal: Bool = false

    var body: some View {
        
           
        HStack(alignment:.bottom) {
            Text(label + " : ")
                .foregroundColor(.yellow).frame(width:150, alignment:.leading)
                VStack(alignment: .leading, spacing: 4) {
                    Text("déclaré")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Group {
                        if key == "observation" {
                            TextEditor(text: Binding(
                                get: {value},
                                set:{ value = $0 }))
                            .frame(minHeight: 50)
                            
                        } else {
                            TextField(label, text: Binding(
                                get: {value},
                                set:{ value = $0 })
                            )
                            .textFieldStyle(.roundedBorder)
                        }
                    }
                }.frame(width: 150)
                VStack {
                    if let real = real {
                        Text("actuelle").font(.caption)
                        Toggle(real, isOn: $choosereal)
                            .toggleStyle(.automatic)
                            .onChange(of: choosereal, {
                                _, newValue in
                                if newValue {
                                    value = real
                                    chooseprevious = false
                                } //else { value = "" }
                            })
                            .onChange (of: value, {choosereal = value == real} )
                    } else { Text("non calculé").foregroundColor(.black) }
                }.frame(width: 150)
            
                VStack {
                    if let previous = previous {
                        Text("précedente").font(.caption)
                        Toggle(previous, isOn: $chooseprevious)
                            .toggleStyle(.automatic)
                            .onChange(of: chooseprevious, {
                                _, newValue in
                                if newValue {
                                    value = previous
                                    choosereal = false
                                } //else { value = "" }
                            })
                            .onChange (of: value, {chooseprevious = value == previous} )
                    } else { Text("absent").foregroundColor(.black) }
                }.frame(width: 150)
            
        }.padding(3)
            .frame(width:700)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(.quaternary))
        }
    
}

struct FieldPrecomparator: View {
    @State var value = "model"
    var previous :String? = "avant"
    var real : String? = "now"
    var body: some View {
        FieldComparator(key:"key", label: "label", value:$value, previous:previous, real: real)
    }
}

#Preview {
    VStack {
        FieldPrecomparator(previous:nil)
        FieldPrecomparator(real:nil)
        FieldPrecomparator(previous:nil, real:nil)
        FieldPrecomparator()
    }
}
