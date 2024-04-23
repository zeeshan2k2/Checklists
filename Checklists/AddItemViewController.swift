import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
    
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
        @IBOutlet weak var doneBarButton: UIBarButtonItem!
        @IBOutlet weak var textField: UITextField!
        
        weak var delegate: AddItemViewControllerDelegate?

        override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    // MARK:- Actions
    @IBAction func cancel() {
    //    navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done() {
    //    print("Contents of the text field: \(textField.text!)")
    //
    //    navigationController?.popViewController(animated: true)
        let item = ChecklistItem()
        item.text = textField.text!
        
        delegate?.addItemViewController(self, didFinishAdding: item)
    }

    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                      willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
    return nil
    }

    // MARK:- Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,
                                              with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}

