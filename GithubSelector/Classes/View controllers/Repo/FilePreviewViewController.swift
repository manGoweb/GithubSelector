//
//  FilePreviewViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 23/08/2017.
//
//

import Foundation


class FilePreviewViewController: ViewController {
    
    //let maxFileSize: Int = 1000000
    let maxFileSize: Int = 100
    
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
        if (file.path!.contains(".jpg") || file.path!.contains(".jpeg") || file.path!.contains(".png")) && file.size <= maxFileSize {
            //createImageView()
            createFileView()
        }
        else {
            if file.size > maxFileSize {
                createFileView()
            }
            else {
                createTextView()
            }
        }
        presentView.file = file
        addAndStylePresentView()
    }
    
    // MARK: Data
    
    private func loadData() {
        guard let config = githubSelector.tokenConfig else {
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
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: Actions
    
    func selectFileTapped(_ sender: UIBarButtonItem) {
        let githubFile = GithubFile(data: data!, name: file.path!, url: file.url!, mode: file.mode!, size: file.size)
        githubSelector.didSelectFile?(githubFile)
        
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
