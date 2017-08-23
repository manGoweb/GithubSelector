//
//  FilePreviewViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation


class FilePreviewViewController: ViewController {
    
    var repo: Repository!
    
    var file: File! {
        didSet {
            title = file.path
        }
    }
    
    var data: Data?
    
    private var presentView: PresentView!
    
    
    // MARK: Elements
    
    func configureNavBar() {
        let branch = UIBarButtonItem(title: Localization.get("gs.files.select"), style: .done, target: self, action: #selector(selectFileTapped(_:)))
        branch.isEnabled = false
        navigationItem.rightBarButtonItem = branch
    }
    
    func addAndStylePresentView() {
        view.addSubview(presentView as! UIView)
        (presentView as! UIView).snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func createImageView() {
        presentView = PresentImageView()
    }
    
    func createTextView() {
        presentView = PresentTextView()
    }
    
    func createFileView() {
        presentView = PresentFileView()
    }
    
    func configureElements() {
        if file.path!.contains(".jpg") || file.path!.contains(".jpeg") || file.path!.contains(".png") {
            createImageView()
        }
        else {
            if file.size > 9999 {
                createFileView()
            }
            else {
                createTextView()
            }
        }
        addAndStylePresentView()
    }
    
    // MARK: Data
    
    private func loadData() {
        guard let config = GithubSelector.shared.tokenConfig else {
            return
        }
        
        Octokit(config).blob(owner: self.repo.owner.login!, repo: self.repo.name!, fileSha: file.sha!) { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let blob):
                    guard let data = Data(base64Encoded: blob.content!, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else {
                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                    self.data = data
                    self.presentView.fileData = data
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                case .failure(let error):
                    print(error)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: Actions
    
    func selectFileTapped(_ sender: UIBarButtonItem) {
        let githubFile = GithubFile(data: data!, name: file.path!, url: file.url!, mode: file.mode!, size: file.size)
        GithubSelector.shared.didSelectFile?(githubFile)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK View lifecycle
    
    override func loadView() {
        super.loadView()
        
        configureNavBar()
        configureElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
}
