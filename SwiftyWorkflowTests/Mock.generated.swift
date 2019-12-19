// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.4.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
@testable import SwiftyWorkflow
@testable import Workflows


// MARK: - Container
open class ContainerMock: Container, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var parent: Container? {
		get {	invocations.append(.p_parent_get); return __p_parent ?? optionalGivenGetterValue(.p_parent_get, "ContainerMock - stub value for parent was not defined") }
		set {	invocations.append(.p_parent_set(.value(newValue))); __p_parent = newValue }
	}
	private var __p_parent: (Container)?

    public var registrations: [RegsteredInstance] {
		get {	invocations.append(.p_registrations_get); return __p_registrations ?? givenGetterValue(.p_registrations_get, "ContainerMock - stub value for registrations was not defined") }
		set {	invocations.append(.p_registrations_set(.value(newValue))); __p_registrations = newValue }
	}
	private var __p_registrations: ([RegsteredInstance])?





    open func register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg> {
        addInvocation(.m_register__typearg_argfactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`arg`).wrapAsGeneric(), Parameter<(Resolver,Arg) -> T>.value(`factory`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_register__typearg_argfactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`arg`).wrapAsGeneric(), Parameter<(Resolver,Arg) -> T>.value(`factory`).wrapAsGeneric())) as? (T.Type, Arg.Type, @escaping (Resolver,Arg) -> T) -> Void
		perform?(`type`, `arg`, `factory`)
		var __value: Registration<T,Arg>
		do {
		    __value = try methodReturnValue(.m_register__typearg_argfactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`arg`).wrapAsGeneric(), Parameter<(Resolver,Arg) -> T>.value(`factory`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T). Use given")
			Failure("Stub return value not specified for register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T). Use given")
		}
		return __value
    }

    open func register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T,Void> {
        addInvocation(.m_register__typefactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<(Resolver) -> T>.value(`factory`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_register__typefactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<(Resolver) -> T>.value(`factory`).wrapAsGeneric())) as? (T.Type, @escaping (Resolver) -> T) -> Void
		perform?(`type`, `factory`)
		var __value: Registration<T,Void>
		do {
		    __value = try methodReturnValue(.m_register__typefactory_factory(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<(Resolver) -> T>.value(`factory`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T). Use given")
			Failure("Stub return value not specified for register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T). Use given")
		}
		return __value
    }

    open func resolve<T>(_ type: T.Type) -> T! {
        addInvocation(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())) as? (T.Type) -> Void
		perform?(`type`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
        addInvocation(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric())) as? (T.Type, Arg) -> Void
		perform?(`type`, `argument`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func instance<T>(_ type: T.Type) -> T? {
        addInvocation(.m_instance__type(Parameter<T.Type>.value(`type`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_instance__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())) as? (T.Type) -> Void
		perform?(`type`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_instance__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        addInvocation(.m_registration__type_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`argument`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_registration__type_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`argument`).wrapAsGeneric())) as? (T.Type, Arg.Type) -> Void
		perform?(`type`, `argument`)
		var __value: Registration<T,Arg>? = nil
		do {
		    __value = try methodReturnValue(.m_registration__type_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg.Type>.value(`argument`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func assemble(in parent: Container) {
        addInvocation(.m_assemble__in_parent(Parameter<Container>.value(`parent`)))
		let perform = methodPerformValue(.m_assemble__in_parent(Parameter<Container>.value(`parent`))) as? (Container) -> Void
		perform?(`parent`)
    }


    fileprivate enum MethodType {
        case m_register__typearg_argfactory_factory(Parameter<GenericAttribute>, Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_register__typefactory_factory(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_resolve__type(Parameter<GenericAttribute>)
        case m_resolve__typewith_argument(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_instance__type(Parameter<GenericAttribute>)
        case m_registration__type_argument(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_assemble__in_parent(Parameter<Container>)
        case p_parent_get
		case p_parent_set(Parameter<Container?>)
        case p_registrations_get
		case p_registrations_set(Parameter<[RegsteredInstance]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_register__typearg_argfactory_factory(let lhsType, let lhsArg, let lhsFactory), .m_register__typearg_argfactory_factory(let rhsType, let rhsArg, let rhsFactory)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsArg, rhs: rhsArg, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsFactory, rhs: rhsFactory, with: matcher) else { return false } 
                return true 
            case (.m_register__typefactory_factory(let lhsType, let lhsFactory), .m_register__typefactory_factory(let rhsType, let rhsFactory)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsFactory, rhs: rhsFactory, with: matcher) else { return false } 
                return true 
            case (.m_resolve__type(let lhsType), .m_resolve__type(let rhsType)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                return true 
            case (.m_resolve__typewith_argument(let lhsType, let lhsArgument), .m_resolve__typewith_argument(let rhsType, let rhsArgument)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsArgument, rhs: rhsArgument, with: matcher) else { return false } 
                return true 
            case (.m_instance__type(let lhsType), .m_instance__type(let rhsType)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                return true 
            case (.m_registration__type_argument(let lhsType, let lhsArgument), .m_registration__type_argument(let rhsType, let rhsArgument)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsArgument, rhs: rhsArgument, with: matcher) else { return false } 
                return true 
            case (.m_assemble__in_parent(let lhsParent), .m_assemble__in_parent(let rhsParent)):
                guard Parameter.compare(lhs: lhsParent, rhs: rhsParent, with: matcher) else { return false } 
                return true 
            case (.p_parent_get,.p_parent_get): return true
			case (.p_parent_set(let left),.p_parent_set(let right)): return Parameter<Container?>.compare(lhs: left, rhs: right, with: matcher)
            case (.p_registrations_get,.p_registrations_get): return true
			case (.p_registrations_set(let left),.p_registrations_set(let right)): return Parameter<[RegsteredInstance]>.compare(lhs: left, rhs: right, with: matcher)
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_register__typearg_argfactory_factory(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_register__typefactory_factory(p0, p1): return p0.intValue + p1.intValue
            case let .m_resolve__type(p0): return p0.intValue
            case let .m_resolve__typewith_argument(p0, p1): return p0.intValue + p1.intValue
            case let .m_instance__type(p0): return p0.intValue
            case let .m_registration__type_argument(p0, p1): return p0.intValue + p1.intValue
            case let .m_assemble__in_parent(p0): return p0.intValue
            case .p_parent_get: return 0
			case .p_parent_set(let newValue): return newValue.intValue
            case .p_registrations_get: return 0
			case .p_registrations_set(let newValue): return newValue.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func parent(getter defaultValue: Container?...) -> PropertyStub {
            return Given(method: .p_parent_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func registrations(getter defaultValue: [RegsteredInstance]...) -> PropertyStub {
            return Given(method: .p_registrations_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func register<T,Arg>(_ type: Parameter<T.Type>, arg: Parameter<Arg.Type>, factory: Parameter<(Resolver,Arg) -> T>, willReturn: Registration<T,Arg>...) -> MethodStub {
            return Given(method: .m_register__typearg_argfactory_factory(`type`.wrapAsGeneric(), `arg`.wrapAsGeneric(), `factory`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func register<T>(_ type: Parameter<T.Type>, factory: Parameter<(Resolver) -> T>, willReturn: Registration<T,Void>...) -> MethodStub {
            return Given(method: .m_register__typefactory_factory(`type`.wrapAsGeneric(), `factory`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolve<T>(_ type: Parameter<T.Type>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_resolve__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func instance<T>(_ type: Parameter<T.Type>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_instance__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func registration<T,Arg>(_ type: Parameter<T.Type>, _ argument: Parameter<Arg.Type>, willReturn: Registration<T,Arg>?...) -> MethodStub {
            return Given(method: .m_registration__type_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func register<T,Arg>(_ type: Parameter<T.Type>, arg: Parameter<Arg.Type>, factory: Parameter<(Resolver,Arg) -> T>, willProduce: (Stubber<Registration<T,Arg>>) -> Void) -> MethodStub {
            let willReturn: [Registration<T,Arg>] = []
			let given: Given = { return Given(method: .m_register__typearg_argfactory_factory(`type`.wrapAsGeneric(), `arg`.wrapAsGeneric(), `factory`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Registration<T,Arg>).self)
			willProduce(stubber)
			return given
        }
        public static func register<T>(_ type: Parameter<T.Type>, factory: Parameter<(Resolver) -> T>, willProduce: (Stubber<Registration<T,Void>>) -> Void) -> MethodStub {
            let willReturn: [Registration<T,Void>] = []
			let given: Given = { return Given(method: .m_register__typefactory_factory(`type`.wrapAsGeneric(), `factory`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Registration<T,Void>).self)
			willProduce(stubber)
			return given
        }
        public static func resolve<T>(_ type: Parameter<T.Type>, willProduce: (Stubber<T?>) -> Void) -> MethodStub {
            let willReturn: [T?] = []
			let given: Given = { return Given(method: .m_resolve__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (T?).self)
			willProduce(stubber)
			return given
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, willProduce: (Stubber<T?>) -> Void) -> MethodStub {
            let willReturn: [T?] = []
			let given: Given = { return Given(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (T?).self)
			willProduce(stubber)
			return given
        }
        public static func instance<T>(_ type: Parameter<T.Type>, willProduce: (Stubber<T?>) -> Void) -> MethodStub {
            let willReturn: [T?] = []
			let given: Given = { return Given(method: .m_instance__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (T?).self)
			willProduce(stubber)
			return given
        }
        public static func registration<T,Arg>(_ type: Parameter<T.Type>, _ argument: Parameter<Arg.Type>, willProduce: (Stubber<Registration<T,Arg>?>) -> Void) -> MethodStub {
            let willReturn: [Registration<T,Arg>?] = []
			let given: Given = { return Given(method: .m_registration__type_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Registration<T,Arg>?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func register<T,Arg>(_ type: Parameter<T.Type>, arg: Parameter<Arg.Type>, factory: Parameter<(Resolver,Arg) -> T>) -> Verify { return Verify(method: .m_register__typearg_argfactory_factory(`type`.wrapAsGeneric(), `arg`.wrapAsGeneric(), `factory`.wrapAsGeneric()))}
        public static func register<T>(_ type: Parameter<T.Type>, factory: Parameter<(Resolver) -> T>) -> Verify { return Verify(method: .m_register__typefactory_factory(`type`.wrapAsGeneric(), `factory`.wrapAsGeneric()))}
        public static func resolve<T>(_ type: Parameter<T.Type>) -> Verify { return Verify(method: .m_resolve__type(`type`.wrapAsGeneric()))}
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>) -> Verify { return Verify(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()))}
        public static func instance<T>(_ type: Parameter<T.Type>) -> Verify { return Verify(method: .m_instance__type(`type`.wrapAsGeneric()))}
        public static func registration<T,Arg>(_ type: Parameter<T.Type>, _ argument: Parameter<Arg.Type>) -> Verify { return Verify(method: .m_registration__type_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()))}
        public static func assemble(in parent: Parameter<Container>) -> Verify { return Verify(method: .m_assemble__in_parent(`parent`))}
        public static var parent: Verify { return Verify(method: .p_parent_get) }
		public static func parent(set newValue: Parameter<Container?>) -> Verify { return Verify(method: .p_parent_set(newValue)) }
        public static var registrations: Verify { return Verify(method: .p_registrations_get) }
		public static func registrations(set newValue: Parameter<[RegsteredInstance]>) -> Verify { return Verify(method: .p_registrations_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func register<T,Arg>(_ type: Parameter<T.Type>, arg: Parameter<Arg.Type>, factory: Parameter<(Resolver,Arg) -> T>, perform: @escaping (T.Type, Arg.Type, @escaping (Resolver,Arg) -> T) -> Void) -> Perform {
            return Perform(method: .m_register__typearg_argfactory_factory(`type`.wrapAsGeneric(), `arg`.wrapAsGeneric(), `factory`.wrapAsGeneric()), performs: perform)
        }
        public static func register<T>(_ type: Parameter<T.Type>, factory: Parameter<(Resolver) -> T>, perform: @escaping (T.Type, @escaping (Resolver) -> T) -> Void) -> Perform {
            return Perform(method: .m_register__typefactory_factory(`type`.wrapAsGeneric(), `factory`.wrapAsGeneric()), performs: perform)
        }
        public static func resolve<T>(_ type: Parameter<T.Type>, perform: @escaping (T.Type) -> Void) -> Perform {
            return Perform(method: .m_resolve__type(`type`.wrapAsGeneric()), performs: perform)
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, perform: @escaping (T.Type, Arg) -> Void) -> Perform {
            return Perform(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), performs: perform)
        }
        public static func instance<T>(_ type: Parameter<T.Type>, perform: @escaping (T.Type) -> Void) -> Perform {
            return Perform(method: .m_instance__type(`type`.wrapAsGeneric()), performs: perform)
        }
        public static func registration<T,Arg>(_ type: Parameter<T.Type>, _ argument: Parameter<Arg.Type>, perform: @escaping (T.Type, Arg.Type) -> Void) -> Perform {
            return Perform(method: .m_registration__type_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), performs: perform)
        }
        public static func assemble(in parent: Parameter<Container>, perform: @escaping (Container) -> Void) -> Perform {
            return Perform(method: .m_assemble__in_parent(`parent`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - NavigationProvider
open class NavigationProviderMock: NavigationProvider, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func move<S>(_ transition: Transition<Void>, from source: S) throws {
        addInvocation(.m_move__transitionfrom_source(Parameter<Transition<Void>>.value(`transition`), Parameter<S>.value(`source`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_move__transitionfrom_source(Parameter<Transition<Void>>.value(`transition`), Parameter<S>.value(`source`).wrapAsGeneric())) as? (Transition<Void>, S) -> Void
		perform?(`transition`, `source`)
		do {
		    _ = try methodReturnValue(.m_move__transitionfrom_source(Parameter<Transition<Void>>.value(`transition`), Parameter<S>.value(`source`).wrapAsGeneric())).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func move<Arg,S>(_ transition: Transition<Arg>, with argument: Arg, from source: S) throws {
        addInvocation(.m_move__transitionwith_argumentfrom_source(Parameter<Transition<Arg>>.value(`transition`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric(), Parameter<S>.value(`source`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_move__transitionwith_argumentfrom_source(Parameter<Transition<Arg>>.value(`transition`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric(), Parameter<S>.value(`source`).wrapAsGeneric())) as? (Transition<Arg>, Arg, S) -> Void
		perform?(`transition`, `argument`, `source`)
		do {
		    _ = try methodReturnValue(.m_move__transitionwith_argumentfrom_source(Parameter<Transition<Arg>>.value(`transition`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric(), Parameter<S>.value(`source`).wrapAsGeneric())).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_move__transitionfrom_source(Parameter<Transition<Void>>, Parameter<GenericAttribute>)
        case m_move__transitionwith_argumentfrom_source(Parameter<GenericAttribute>, Parameter<GenericAttribute>, Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_move__transitionfrom_source(let lhsTransition, let lhsSource), .m_move__transitionfrom_source(let rhsTransition, let rhsSource)):
                guard Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsSource, rhs: rhsSource, with: matcher) else { return false } 
                return true 
            case (.m_move__transitionwith_argumentfrom_source(let lhsTransition, let lhsArgument, let lhsSource), .m_move__transitionwith_argumentfrom_source(let rhsTransition, let rhsArgument, let rhsSource)):
                guard Parameter.compare(lhs: lhsTransition, rhs: rhsTransition, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsArgument, rhs: rhsArgument, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsSource, rhs: rhsSource, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_move__transitionfrom_source(p0, p1): return p0.intValue + p1.intValue
            case let .m_move__transitionwith_argumentfrom_source(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func move<S>(_ transition: Parameter<Transition<Void>>, from source: Parameter<S>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_move__transitionfrom_source(`transition`, `source`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func move<S>(_ transition: Parameter<Transition<Void>>, from source: Parameter<S>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_move__transitionfrom_source(`transition`, `source`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func move<Arg,S>(_ transition: Parameter<Transition<Arg>>, with argument: Parameter<Arg>, from source: Parameter<S>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_move__transitionwith_argumentfrom_source(`transition`.wrapAsGeneric(), `argument`.wrapAsGeneric(), `source`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func move<Arg,S>(_ transition: Parameter<Transition<Arg>>, with argument: Parameter<Arg>, from source: Parameter<S>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_move__transitionwith_argumentfrom_source(`transition`.wrapAsGeneric(), `argument`.wrapAsGeneric(), `source`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func move<S>(_ transition: Parameter<Transition<Void>>, from source: Parameter<S>) -> Verify { return Verify(method: .m_move__transitionfrom_source(`transition`, `source`.wrapAsGeneric()))}
        public static func move<Arg,S>(_ transition: Parameter<Transition<Arg>>, with argument: Parameter<Arg>, from source: Parameter<S>) -> Verify { return Verify(method: .m_move__transitionwith_argumentfrom_source(`transition`.wrapAsGeneric(), `argument`.wrapAsGeneric(), `source`.wrapAsGeneric()))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func move<S>(_ transition: Parameter<Transition<Void>>, from source: Parameter<S>, perform: @escaping (Transition<Void>, S) -> Void) -> Perform {
            return Perform(method: .m_move__transitionfrom_source(`transition`, `source`.wrapAsGeneric()), performs: perform)
        }
        public static func move<Arg,S>(_ transition: Parameter<Transition<Arg>>, with argument: Parameter<Arg>, from source: Parameter<S>, perform: @escaping (Transition<Arg>, Arg, S) -> Void) -> Perform {
            return Perform(method: .m_move__transitionwith_argumentfrom_source(`transition`.wrapAsGeneric(), `argument`.wrapAsGeneric(), `source`.wrapAsGeneric()), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - Resolver
open class ResolverMock: Resolver, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func resolve<T>(_ type: T.Type) -> T! {
        addInvocation(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())) as? (T.Type) -> Void
		perform?(`type`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_resolve__type(Parameter<T.Type>.value(`type`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
        addInvocation(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric())) as? (T.Type, Arg) -> Void
		perform?(`type`, `argument`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_resolve__typewith_argument(Parameter<T.Type>.value(`type`).wrapAsGeneric(), Parameter<Arg>.value(`argument`).wrapAsGeneric())).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_resolve__type(Parameter<GenericAttribute>)
        case m_resolve__typewith_argument(Parameter<GenericAttribute>, Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_resolve__type(let lhsType), .m_resolve__type(let rhsType)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                return true 
            case (.m_resolve__typewith_argument(let lhsType, let lhsArgument), .m_resolve__typewith_argument(let rhsType, let rhsArgument)):
                guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsArgument, rhs: rhsArgument, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_resolve__type(p0): return p0.intValue
            case let .m_resolve__typewith_argument(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func resolve<T>(_ type: Parameter<T.Type>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_resolve__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolve<T>(_ type: Parameter<T.Type>, willProduce: (Stubber<T?>) -> Void) -> MethodStub {
            let willReturn: [T?] = []
			let given: Given = { return Given(method: .m_resolve__type(`type`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (T?).self)
			willProduce(stubber)
			return given
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, willProduce: (Stubber<T?>) -> Void) -> MethodStub {
            let willReturn: [T?] = []
			let given: Given = { return Given(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (T?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func resolve<T>(_ type: Parameter<T.Type>) -> Verify { return Verify(method: .m_resolve__type(`type`.wrapAsGeneric()))}
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>) -> Verify { return Verify(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func resolve<T>(_ type: Parameter<T.Type>, perform: @escaping (T.Type) -> Void) -> Perform {
            return Perform(method: .m_resolve__type(`type`.wrapAsGeneric()), performs: perform)
        }
        public static func resolve<T,Arg>(_ type: Parameter<T.Type>, with argument: Parameter<Arg>, perform: @escaping (T.Type, Arg) -> Void) -> Perform {
            return Perform(method: .m_resolve__typewith_argument(`type`.wrapAsGeneric(), `argument`.wrapAsGeneric()), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - ViewType
open class ViewTypeMock: ViewType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var presentingView: ViewType? {
		get {	invocations.append(.p_presentingView_get); return __p_presentingView ?? optionalGivenGetterValue(.p_presentingView_get, "ViewTypeMock - stub value for presentingView was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_presentingView = newValue }
	}
	private var __p_presentingView: (ViewType)?

    public var presentedView: ViewType? {
		get {	invocations.append(.p_presentedView_get); return __p_presentedView ?? optionalGivenGetterValue(.p_presentedView_get, "ViewTypeMock - stub value for presentedView was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_presentedView = newValue }
	}
	private var __p_presentedView: (ViewType)?

    public var navigationView: ViewType? {
		get {	invocations.append(.p_navigationView_get); return __p_navigationView ?? optionalGivenGetterValue(.p_navigationView_get, "ViewTypeMock - stub value for navigationView was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_navigationView = newValue }
	}
	private var __p_navigationView: (ViewType)?

    public var handleError: (Error) -> Void {
		get {	invocations.append(.p_handleError_get); return __p_handleError ?? givenGetterValue(.p_handleError_get, "ViewTypeMock - stub value for handleError was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_handleError = newValue }
	}
	private var __p_handleError: ((Error) -> Void)?





    open func push(_ view: ViewType, animated: Bool) {
        addInvocation(.m_push__viewanimated_animated(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_push__viewanimated_animated(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`animated`))) as? (ViewType, Bool) -> Void
		perform?(`view`, `animated`)
    }

    open func pop(animated: Bool) {
        addInvocation(.m_pop__animated_animated(Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_pop__animated_animated(Parameter<Bool>.value(`animated`))) as? (Bool) -> Void
		perform?(`animated`)
    }

    open func popToRoot(animated: Bool) {
        addInvocation(.m_popToRoot__animated_animated(Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_popToRoot__animated_animated(Parameter<Bool>.value(`animated`))) as? (Bool) -> Void
		perform?(`animated`)
    }

    open func pop(to source: ViewType, animated: Bool) {
        addInvocation(.m_pop__to_sourceanimated_animated(Parameter<ViewType>.value(`source`), Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_pop__to_sourceanimated_animated(Parameter<ViewType>.value(`source`), Parameter<Bool>.value(`animated`))) as? (ViewType, Bool) -> Void
		perform?(`source`, `animated`)
    }

    open func present(_ view: ViewType, animated flag: Bool) {
        addInvocation(.m_present__viewanimated_flag(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`flag`)))
		let perform = methodPerformValue(.m_present__viewanimated_flag(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`flag`))) as? (ViewType, Bool) -> Void
		perform?(`view`, `flag`)
    }

    open func present(_ view: ViewType, animated flag: Bool, completion: NavigationCompletion?) {
        addInvocation(.m_present__viewanimated_flagcompletion_completion(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`flag`), Parameter<(NavigationCompletion)?>.value(`completion`)))
		let perform = methodPerformValue(.m_present__viewanimated_flagcompletion_completion(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`flag`), Parameter<(NavigationCompletion)?>.value(`completion`))) as? (ViewType, Bool, NavigationCompletion?) -> Void
		perform?(`view`, `flag`, `completion`)
    }

    open func present(error: Error) {
        addInvocation(.m_present__error_error(Parameter<Error>.value(`error`)))
		let perform = methodPerformValue(.m_present__error_error(Parameter<Error>.value(`error`))) as? (Error) -> Void
		perform?(`error`)
    }

    open func dismiss(animated flag: Bool) {
        addInvocation(.m_dismiss__animated_flag(Parameter<Bool>.value(`flag`)))
		let perform = methodPerformValue(.m_dismiss__animated_flag(Parameter<Bool>.value(`flag`))) as? (Bool) -> Void
		perform?(`flag`)
    }

    open func dismiss(animated flag: Bool, completion: NavigationCompletion?) {
        addInvocation(.m_dismiss__animated_flagcompletion_completion(Parameter<Bool>.value(`flag`), Parameter<(NavigationCompletion)?>.value(`completion`)))
		let perform = methodPerformValue(.m_dismiss__animated_flagcompletion_completion(Parameter<Bool>.value(`flag`), Parameter<(NavigationCompletion)?>.value(`completion`))) as? (Bool, NavigationCompletion?) -> Void
		perform?(`flag`, `completion`)
    }

    open func replace(_ view: ViewType, animated: Bool) {
        addInvocation(.m_replace__viewanimated_animated(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`animated`)))
		let perform = methodPerformValue(.m_replace__viewanimated_animated(Parameter<ViewType>.value(`view`), Parameter<Bool>.value(`animated`))) as? (ViewType, Bool) -> Void
		perform?(`view`, `animated`)
    }

    open func wrappedInNavigation() -> ViewType {
        addInvocation(.m_wrappedInNavigation)
		let perform = methodPerformValue(.m_wrappedInNavigation) as? () -> Void
		perform?()
		var __value: ViewType
		do {
		    __value = try methodReturnValue(.m_wrappedInNavigation).casted()
		} catch {
			onFatalFailure("Stub return value not specified for wrappedInNavigation(). Use given")
			Failure("Stub return value not specified for wrappedInNavigation(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_push__viewanimated_animated(Parameter<ViewType>, Parameter<Bool>)
        case m_pop__animated_animated(Parameter<Bool>)
        case m_popToRoot__animated_animated(Parameter<Bool>)
        case m_pop__to_sourceanimated_animated(Parameter<ViewType>, Parameter<Bool>)
        case m_present__viewanimated_flag(Parameter<ViewType>, Parameter<Bool>)
        case m_present__viewanimated_flagcompletion_completion(Parameter<ViewType>, Parameter<Bool>, Parameter<(NavigationCompletion)?>)
        case m_present__error_error(Parameter<Error>)
        case m_dismiss__animated_flag(Parameter<Bool>)
        case m_dismiss__animated_flagcompletion_completion(Parameter<Bool>, Parameter<(NavigationCompletion)?>)
        case m_replace__viewanimated_animated(Parameter<ViewType>, Parameter<Bool>)
        case m_wrappedInNavigation
        case p_presentingView_get
        case p_presentedView_get
        case p_navigationView_get
        case p_handleError_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_push__viewanimated_animated(let lhsView, let lhsAnimated), .m_push__viewanimated_animated(let rhsView, let rhsAnimated)):
                guard Parameter.compare(lhs: lhsView, rhs: rhsView, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            case (.m_pop__animated_animated(let lhsAnimated), .m_pop__animated_animated(let rhsAnimated)):
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            case (.m_popToRoot__animated_animated(let lhsAnimated), .m_popToRoot__animated_animated(let rhsAnimated)):
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            case (.m_pop__to_sourceanimated_animated(let lhsSource, let lhsAnimated), .m_pop__to_sourceanimated_animated(let rhsSource, let rhsAnimated)):
                guard Parameter.compare(lhs: lhsSource, rhs: rhsSource, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            case (.m_present__viewanimated_flag(let lhsView, let lhsFlag), .m_present__viewanimated_flag(let rhsView, let rhsFlag)):
                guard Parameter.compare(lhs: lhsView, rhs: rhsView, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsFlag, rhs: rhsFlag, with: matcher) else { return false } 
                return true 
            case (.m_present__viewanimated_flagcompletion_completion(let lhsView, let lhsFlag, let lhsCompletion), .m_present__viewanimated_flagcompletion_completion(let rhsView, let rhsFlag, let rhsCompletion)):
                guard Parameter.compare(lhs: lhsView, rhs: rhsView, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsFlag, rhs: rhsFlag, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            case (.m_present__error_error(let lhsError), .m_present__error_error(let rhsError)):
                guard Parameter.compare(lhs: lhsError, rhs: rhsError, with: matcher) else { return false } 
                return true 
            case (.m_dismiss__animated_flag(let lhsFlag), .m_dismiss__animated_flag(let rhsFlag)):
                guard Parameter.compare(lhs: lhsFlag, rhs: rhsFlag, with: matcher) else { return false } 
                return true 
            case (.m_dismiss__animated_flagcompletion_completion(let lhsFlag, let lhsCompletion), .m_dismiss__animated_flagcompletion_completion(let rhsFlag, let rhsCompletion)):
                guard Parameter.compare(lhs: lhsFlag, rhs: rhsFlag, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            case (.m_replace__viewanimated_animated(let lhsView, let lhsAnimated), .m_replace__viewanimated_animated(let rhsView, let rhsAnimated)):
                guard Parameter.compare(lhs: lhsView, rhs: rhsView, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsAnimated, rhs: rhsAnimated, with: matcher) else { return false } 
                return true 
            case (.m_wrappedInNavigation, .m_wrappedInNavigation):
                return true 
            case (.p_presentingView_get,.p_presentingView_get): return true
            case (.p_presentedView_get,.p_presentedView_get): return true
            case (.p_navigationView_get,.p_navigationView_get): return true
            case (.p_handleError_get,.p_handleError_get): return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_push__viewanimated_animated(p0, p1): return p0.intValue + p1.intValue
            case let .m_pop__animated_animated(p0): return p0.intValue
            case let .m_popToRoot__animated_animated(p0): return p0.intValue
            case let .m_pop__to_sourceanimated_animated(p0, p1): return p0.intValue + p1.intValue
            case let .m_present__viewanimated_flag(p0, p1): return p0.intValue + p1.intValue
            case let .m_present__viewanimated_flagcompletion_completion(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_present__error_error(p0): return p0.intValue
            case let .m_dismiss__animated_flag(p0): return p0.intValue
            case let .m_dismiss__animated_flagcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_replace__viewanimated_animated(p0, p1): return p0.intValue + p1.intValue
            case .m_wrappedInNavigation: return 0
            case .p_presentingView_get: return 0
            case .p_presentedView_get: return 0
            case .p_navigationView_get: return 0
            case .p_handleError_get: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func presentingView(getter defaultValue: ViewType?...) -> PropertyStub {
            return Given(method: .p_presentingView_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func presentedView(getter defaultValue: ViewType?...) -> PropertyStub {
            return Given(method: .p_presentedView_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func navigationView(getter defaultValue: ViewType?...) -> PropertyStub {
            return Given(method: .p_navigationView_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func handleError(getter defaultValue: (Error) -> Void...) -> PropertyStub {
            return Given(method: .p_handleError_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func wrappedInNavigation(willReturn: ViewType...) -> MethodStub {
            return Given(method: .m_wrappedInNavigation, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func wrappedInNavigation(willProduce: (Stubber<ViewType>) -> Void) -> MethodStub {
            let willReturn: [ViewType] = []
			let given: Given = { return Given(method: .m_wrappedInNavigation, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ViewType).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func push(_ view: Parameter<ViewType>, animated: Parameter<Bool>) -> Verify { return Verify(method: .m_push__viewanimated_animated(`view`, `animated`))}
        public static func pop(animated: Parameter<Bool>) -> Verify { return Verify(method: .m_pop__animated_animated(`animated`))}
        public static func popToRoot(animated: Parameter<Bool>) -> Verify { return Verify(method: .m_popToRoot__animated_animated(`animated`))}
        public static func pop(to source: Parameter<ViewType>, animated: Parameter<Bool>) -> Verify { return Verify(method: .m_pop__to_sourceanimated_animated(`source`, `animated`))}
        public static func present(_ view: Parameter<ViewType>, animated flag: Parameter<Bool>) -> Verify { return Verify(method: .m_present__viewanimated_flag(`view`, `flag`))}
        public static func present(_ view: Parameter<ViewType>, animated flag: Parameter<Bool>, completion: Parameter<(NavigationCompletion)?>) -> Verify { return Verify(method: .m_present__viewanimated_flagcompletion_completion(`view`, `flag`, `completion`))}
        public static func present(error: Parameter<Error>) -> Verify { return Verify(method: .m_present__error_error(`error`))}
        public static func dismiss(animated flag: Parameter<Bool>) -> Verify { return Verify(method: .m_dismiss__animated_flag(`flag`))}
        public static func dismiss(animated flag: Parameter<Bool>, completion: Parameter<(NavigationCompletion)?>) -> Verify { return Verify(method: .m_dismiss__animated_flagcompletion_completion(`flag`, `completion`))}
        public static func replace(_ view: Parameter<ViewType>, animated: Parameter<Bool>) -> Verify { return Verify(method: .m_replace__viewanimated_animated(`view`, `animated`))}
        public static func wrappedInNavigation() -> Verify { return Verify(method: .m_wrappedInNavigation)}
        public static var presentingView: Verify { return Verify(method: .p_presentingView_get) }
        public static var presentedView: Verify { return Verify(method: .p_presentedView_get) }
        public static var navigationView: Verify { return Verify(method: .p_navigationView_get) }
        public static var handleError: Verify { return Verify(method: .p_handleError_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func push(_ view: Parameter<ViewType>, animated: Parameter<Bool>, perform: @escaping (ViewType, Bool) -> Void) -> Perform {
            return Perform(method: .m_push__viewanimated_animated(`view`, `animated`), performs: perform)
        }
        public static func pop(animated: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_pop__animated_animated(`animated`), performs: perform)
        }
        public static func popToRoot(animated: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_popToRoot__animated_animated(`animated`), performs: perform)
        }
        public static func pop(to source: Parameter<ViewType>, animated: Parameter<Bool>, perform: @escaping (ViewType, Bool) -> Void) -> Perform {
            return Perform(method: .m_pop__to_sourceanimated_animated(`source`, `animated`), performs: perform)
        }
        public static func present(_ view: Parameter<ViewType>, animated flag: Parameter<Bool>, perform: @escaping (ViewType, Bool) -> Void) -> Perform {
            return Perform(method: .m_present__viewanimated_flag(`view`, `flag`), performs: perform)
        }
        public static func present(_ view: Parameter<ViewType>, animated flag: Parameter<Bool>, completion: Parameter<(NavigationCompletion)?>, perform: @escaping (ViewType, Bool, NavigationCompletion?) -> Void) -> Perform {
            return Perform(method: .m_present__viewanimated_flagcompletion_completion(`view`, `flag`, `completion`), performs: perform)
        }
        public static func present(error: Parameter<Error>, perform: @escaping (Error) -> Void) -> Perform {
            return Perform(method: .m_present__error_error(`error`), performs: perform)
        }
        public static func dismiss(animated flag: Parameter<Bool>, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .m_dismiss__animated_flag(`flag`), performs: perform)
        }
        public static func dismiss(animated flag: Parameter<Bool>, completion: Parameter<(NavigationCompletion)?>, perform: @escaping (Bool, NavigationCompletion?) -> Void) -> Perform {
            return Perform(method: .m_dismiss__animated_flagcompletion_completion(`flag`, `completion`), performs: perform)
        }
        public static func replace(_ view: Parameter<ViewType>, animated: Parameter<Bool>, perform: @escaping (ViewType, Bool) -> Void) -> Perform {
            return Perform(method: .m_replace__viewanimated_animated(`view`, `animated`), performs: perform)
        }
        public static func wrappedInNavigation(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_wrappedInNavigation, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - Window
open class WindowMock: Window, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var rootView: ViewType? {
		get {	invocations.append(.p_rootView_get); return __p_rootView ?? optionalGivenGetterValue(.p_rootView_get, "WindowMock - stub value for rootView was not defined") }
		set {	invocations.append(.p_rootView_set(.value(newValue))); __p_rootView = newValue }
	}
	private var __p_rootView: (ViewType)?





    open func makeKeyAndVisible() {
        addInvocation(.m_makeKeyAndVisible)
		let perform = methodPerformValue(.m_makeKeyAndVisible) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_makeKeyAndVisible
        case p_rootView_get
		case p_rootView_set(Parameter<ViewType?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_makeKeyAndVisible, .m_makeKeyAndVisible):
                return true 
            case (.p_rootView_get,.p_rootView_get): return true
			case (.p_rootView_set(let left),.p_rootView_set(let right)): return Parameter<ViewType?>.compare(lhs: left, rhs: right, with: matcher)
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_makeKeyAndVisible: return 0
            case .p_rootView_get: return 0
			case .p_rootView_set(let newValue): return newValue.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func rootView(getter defaultValue: ViewType?...) -> PropertyStub {
            return Given(method: .p_rootView_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func makeKeyAndVisible() -> Verify { return Verify(method: .m_makeKeyAndVisible)}
        public static var rootView: Verify { return Verify(method: .p_rootView_get) }
		public static func rootView(set newValue: Parameter<ViewType?>) -> Verify { return Verify(method: .p_rootView_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func makeKeyAndVisible(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_makeKeyAndVisible, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

