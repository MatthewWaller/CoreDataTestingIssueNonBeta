import XCTest
import CoreData
@testable import CoreDataTestingIssueNonBeta

class CoreDataTestingIssueTests: XCTestCase {
    private var context: NSManagedObjectContext?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.context = NSManagedObjectContext.contextForTests()
    }
    
    func testExampleOne() throws {
        guard let context = context else {
            return
        }
        let note = Note(context: context)
        note.title = "Hello"
        try! context.save()
    }
    
    func testExampleTwo() throws {
        guard let context = context else {
            return
        }
        let note = Note(context: context)
        note.title = "Hello"
        try! context.save()
    }
}

extension NSManagedObjectContext {
    
    class func contextForTests() -> NSManagedObjectContext {
        // Get the model
        let model = NSManagedObjectModel.mergedModel(from: Bundle.allBundles)!
        
        let container = NSPersistentContainer(name: "TestIssuesModel", managedObjectModel: model)
        container.persistentStoreDescriptions.first?.type = NSInMemoryStoreType
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        // Create and configure the coordinator
        return container.viewContext
    }
}
