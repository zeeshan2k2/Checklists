import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)

    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem)
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
    
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddItemViewControllerDelegate?

    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }


    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }

    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }

    override func tableView(_ tableView: UITableView,
                      willSelectRowAt indexPath: IndexPath)
    -> IndexPath? {
        return nil
    }

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

