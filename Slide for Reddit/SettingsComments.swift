//
//  SettingsComments.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 6/28/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//

import UIKit

class SettingsComments: UITableViewController {
    
    var disableNavigationBarCell: UITableViewCell = UITableViewCell()
    var disableNavigationBar = UISwitch()
    
    var disableColorCell: UITableViewCell = UITableViewCell()
    var disableColor = UISwitch()
    
    var collapseDefaultCell: UITableViewCell = UITableViewCell()
    var collapseDefault = UISwitch()
    
    var swapLongPressCell: UITableViewCell = UITableViewCell()
    var swapLongPress = UISwitch()
    
    var collapseFullyCell: UITableViewCell = UITableViewCell()
    var collapseFully = UISwitch()

    var highlightOpCell: UITableViewCell = UITableViewCell()
    var highlightOp = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = ColorUtil.getColorForSub(sub: "")
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func switchIsChanged(_ changed: UISwitch) {
        if(changed == disableNavigationBar){
            SettingValues.disableNavigationBar = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_disableNavigationBar)
        } else if(changed == disableColor){
            SettingValues.disableColor = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_disableColor)
        } else if(changed == collapseDefault){
            SettingValues.collapseDefault = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_collapseDefault)
        } else if(changed == swapLongPress){
            SettingValues.swapLongPress = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_swapLongPress)
        } else if(changed == collapseFully){
            SettingValues.collapseFully = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_collapseFully)
        } else if(changed == highlightOp){
            SettingValues.highlightOp = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_highlightOp)
        }
        UserDefaults.standard.synchronize()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.textColor = ColorUtil.baseAccent
        label.font = FontGenerator.boldFontOfSize(size: 20, submission: true)
        let toReturn = label.withPadding(padding: UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 0))
        toReturn.backgroundColor = ColorUtil.backgroundColor
        
        switch(section) {
        case 0: label.text  = "Preview"
            break
        case 1: label.text  = "Display"
            break
        case 2: label.text = "Actionbar"
            break
        default: label.text  = ""
            break
        }
        return toReturn
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func createCell(_ cell: UITableViewCell, _ switchV: UISwitch? = nil, isOn: Bool, text: String){
        cell.textLabel?.text = text
        cell.textLabel?.textColor = ColorUtil.fontColor
        cell.backgroundColor = ColorUtil.foregroundColor
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if let s = switchV {
            s.isOn = isOn
            s.addTarget(self, action: #selector(SettingsLayout.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
            cell.accessoryView = s
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = ColorUtil.backgroundColor
        // set the title
        self.title = "Comments"
        self.tableView.separatorStyle = .none

        createCell(disableNavigationBarCell, disableNavigationBar, isOn: SettingValues.disableNavigationBar, text: "Disable comment navigation toolbar")
        createCell(disableColorCell, disableColor, isOn: SettingValues.disableColor, text: "Monochrome comment depth indicators")
        createCell(collapseDefaultCell, collapseDefault, isOn: SettingValues.collapseDefault, text: "Collapse all comments automatically")
        createCell(swapLongPressCell, swapLongPress, isOn: SettingValues.swapLongPress, text: "Swap tap and long press actions")
        createCell(collapseFullyCell, collapseFully, isOn: SettingValues.collapseFully, text: "Collapse comments fully")
        createCell(highlightOpCell, highlightOp, isOn: SettingValues.highlightOp, text: "Highlight op replies of parent comments")

        self.tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0){
            return 0
        }
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.collapseDefaultCell
            case 1: return self.collapseFullyCell
            case 2: return self.disableColorCell
            case 3: return self.swapLongPressCell
            case 4: return self.highlightOpCell
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 5    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    
}
