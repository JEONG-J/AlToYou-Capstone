//
//  PopUpViewController.swift
//  AltoYou
//
//  Created by 정의찬 on 11/9/23.
//

import UIKit
import SnapKit

class PopUpViewController: UIViewController {
    
    private var messageText: String?
    private var contentView: UIView?
    
    ///MARK: - Alert 커스텀 메인 뷰
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.84, green: 0.93, blue: 0.95, alpha: 1.00)
        view.layer.cornerRadius = 30
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        return view
    }()
    
    ///MARK: - Alert 설명 및 버튼 스택 뷰
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .center
        return view
    }()
    
    ///MARk: - Alert 버튼 스택뷰
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillEqually
        return view
    }()
    
    ///MARK: - AlertView 메시지 글
    private lazy var messageLabel: UILabel? = {
        guard messageText != nil else { return nil}
        
        let label = UILabel()
        label.text = messageText
        label.textAlignment = .center
        label.font = UIFont(name: "Goryeong-Strawberry", size: 45)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Init
    
    ///MARK: - 입력받은 텍스트 초기화
    convenience init(messageText: String? = nil){
        self.init()
        self.messageText = messageText
        modalPresentationStyle = .overFullScreen
    }
    
    ///MARK: - Alert뷰 생성 초기화
    convenience init(contentView: UIView){
        self.init()
        self.contentView = contentView
        modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubview()
        makeConstraints()
    }
    
    ///MARK: - Alert뷰 발생
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        DispatchQueue.main.async{
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                [weak self] in
                self?.containerView.transform = .identity
                self?.containerView.isHidden = false
            }
        }
    }
    
    ///MARK: - Alert뷰 삭제
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.async{
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn){
                [weak self] in
                self?.containerView.transform = .identity
                self?.containerView.isHidden = true
            }
        }
    }
    
    public func addActionBtn(title: String? = nil, backgroundColor: UIColor = UIColor(red: 0.57, green: 0.80, blue: 0.39, alpha: 1.00), completion: (() -> Void)? = nil) {
        guard let title = title else {return}
        
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Goryeong-Strawberry", size: 35)
        button.setTitle(title, for: .normal)
        button.setBackgroundImage(backgroundColor.image(), for: .normal)
        
        button.setTitleColor(.gray, for: .disabled)
        button.setBackgroundImage(backgroundColor.image(), for: .disabled)
        
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        
        
        button.addAction(for: .touchUpInside) { _ in
            completion?()
        }
        
        buttonStackView.addArrangedSubview(button)
    }
    
    ///MARK: - 뷰설정
    private func setupView(){
        view.addSubview(containerView)
        containerView.addSubview(containerStackView)
        view.backgroundColor = .black.withAlphaComponent(0.8)
    }
    ///MARK: - 뷰 추가하기
    private func addSubview(){
        view.addSubview(containerStackView)
        
        if let contentView = contentView {
            containerStackView.addSubview(contentView)
        } else {
            if let messageLabel = messageLabel {
                containerStackView.addArrangedSubview(messageLabel)
            }
        }
        
        if let lastView = containerStackView.subviews.last{
            containerStackView.setCustomSpacing(24.0, after: lastView)
        }
        
        containerStackView.addArrangedSubview(buttonStackView)
    }
    
    ///MAKR: - 제약 조건 설정
    private func makeConstraints(){
        containerView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(232)
            make.width.equalTo(763)
        }
        
        containerStackView.snp.makeConstraints{ make in
            make.top.equalTo(containerView.snp.top).offset(32)
            make.centerX.equalTo(containerView)
            make.width.equalTo(430)
            make.height.equalTo(166)
        }
        
        buttonStackView.snp.makeConstraints{ make in
            make.height.equalTo(70)
            make.width.equalTo(300  )
        }
    }
}

//MARK: - Extension
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage{
        return UIGraphicsImageRenderer(size: size).image{ renderContext in self.setFill()
            renderContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}


extension UIControl {
    public typealias UIControlTargetClosure = (UIControl) -> ()
    
    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure
            
        } set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }
    
}
