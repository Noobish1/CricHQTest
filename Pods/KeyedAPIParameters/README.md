[![Build Status](https://travis-ci.org/Noobish1/KeyedAPIParameters.svg?branch=master)](https://travis-ci.org/Noobish1/KeyedAPIParameters) [![codebeat badge](https://codebeat.co/badges/108375ce-43fc-433d-af74-ba5584254c04)](https://codebeat.co/projects/github-com-noobish1-keyedapiparameters-master) [![codecov](https://codecov.io/gh/Noobish1/KeyedAPIParameters/branch/master/graph/badge.svg)](https://codecov.io/gh/Noobish1/KeyedAPIParameters)

# KeyedAPIParameters

A concept for API parameters in Swift.

## Requirements
 
- Xcode 8+
- Swift 3+
- iOS 8+

This framework is based around a few main components which I will outline below.

<details>
<summary>APIParamConvertible</summary>

APIParamConvertible is a protocol which defines an object that can safely be turned into a value for a given HTTP method. The reason we pass in the HTTP method is that different HTTP methods may require different output. For example GET requests require `String`s whereas POST requests can use anything can be encoded to JSON.

```swift
public protocol APIParamConvertible {
    func value(forHTTPMethod method: HTTPMethod) -> Any
}
```

By looking in `APIParamConvertible.swift` you can see the built-in convertible types.
</details>

<details>
<summary>APIParamValue</summary>


APIParamValue is a wrapper for all the types that we allow in API parameters, more can be added over time, this is just a decent start.

```swift
public enum APIParamValue: APIParamConvertible {
    case convertible(APIParamConvertible)
    case optionalConvertible(APIParamConvertible?)
    case arrayConvertible([APIParamConvertible])
    case null
    case timestampInMillis(Date)
}
```
</details>

<details>
<summary>APIParameters</summary>


`APIParameters` is the first level of protocols which you can make your parameters conform to. The reason `APIParameters` exists is it lets you have `String` keys without having to make an enum, which some may prefer.

```swift
public protocol APIParameters: APIParamConvertible {
    func toParamDictionary() -> [String : APIParamValue]
}
```

A basic example would be:
```swift
import KeyedAPIParameters

struct Object {
    let stringProperty: String
}

extension Object: APIParameters {    
    func toParamDictionary() -> [String : APIParamValue] {
        return ["stringProperty" : .convertible(stringProperty)]
    }
}
```
</details>

<details>
<summary>KeyedAPIParameters</summary>


`KeyedAPIParameters` is the highest level of protocols you can make your parameters conform to. The protocol forces you to define an enum for the parameter keys.

```swift
public protocol KeyedAPIParameters: APIParameters {
    associatedtype Key: ParamJSONKey
    
    func toKeyedDictionary() -> [Key: APIParamValue]
}
```

A basic example would be:
```swift
import KeyedAPIParameters

struct Object {
    let stringProperty: String
}

extension Object: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case stringProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [.stringProperty : .convertible(stringProperty)]
    }
}
```
</details>

<details>
<summary>Full example</summary>


```swift
import KeyedAPIParameters

struct InnerObject {
    let innerStringProperty: String
}

extension InnerObject: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case innerStringProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [.innerStringProperty : .convertible(innerStringProperty)]
    }
}

struct Object {
    let stringProperty: String
    let intProperty: Int
    let floatProperty: Float
    let doubleProperty: Double
    let boolProperty: Bool
    let optionalProperty: String?
    let arrayProperty: [String]
    let nestedProperty: InnerObject
}

extension Object: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case stringProperty
        case intProperty
        case floatProperty
        case doubleProperty
        case boolProperty
        case optionalProperty
        case arrayProperty
        case nestedProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [
            .stringProperty: .convertible(stringProperty),
            .intProperty: .convertible(intProperty),
            .floatProperty: .convertible(intProperty),
            .doubleProperty: .convertible(doubleProperty),
            .boolProperty: .convertible(boolProperty),
            .optionalProperty: .optionalConvertible(optionalProperty),
            .arrayProperty: .arrayConvertible(arrayProperty),
            .nestedProperty: .convertible(nestedProperty)
        ]
    }
}
```
</details>