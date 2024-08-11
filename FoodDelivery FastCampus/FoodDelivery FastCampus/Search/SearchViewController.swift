//
//  SearchViewController.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 04/07/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel : SearchViewModelProtocol
    
    private lazy var searchTextField : UISearchTextField = {
        let textField : UISearchTextField = UISearchTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.addTarget(self, action: #selector(textFieldValuedidChange), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RestaurantListCell.self, forCellWithReuseIdentifier: "restaurantList")
        collectionView.register(CuisineCarouselListCell.self, forCellWithReuseIdentifier: "cuisineCarouselList")
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        return collectionView
    }()
    
    init(viewModel : SearchViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
    }
}

private extension SearchViewController{
    @objc
    func textFieldValuedidChange(){
        viewModel.onTextFieldValueDidChanged(text: searchTextField.text ?? "")
    }
}

extension SearchViewController: SearchViewModelDelegate{
    
    
    func setupView(){
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func navigateToRestaurantPage(restaurantData: RestaurantData) {
        let viewModel : RestaurantViewModel = RestaurantViewModel(restaurantData: restaurantData)
        let viewController: RestaurantViewController = RestaurantViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.getFilteredCuisineList().isEmpty && viewModel.getFilteredRestaurantList().isEmpty{
            return 0
        }
        
        else if viewModel.getFilteredCuisineList().isEmpty || viewModel.getFilteredRestaurantList().isEmpty{
            return 1
        }
        return 2
        //section 1 carousel
        //section 2 restaurant
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if viewModel.getFilteredCuisineList().isEmpty && !viewModel.getFilteredRestaurantList().isEmpty{
                //restaurant
                return viewModel.getFilteredRestaurantList().count
            }else{
                let numberOfSection = !viewModel.getFilteredCuisineList().isEmpty ? 1 : 0
                return numberOfSection
            }
        }else{
            return viewModel.getFilteredRestaurantList().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if viewModel.getFilteredCuisineList().isEmpty && !viewModel.getFilteredRestaurantList().isEmpty{
                //restaurant
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantList", for: indexPath)
                        as? RestaurantListCell else {
                    return UICollectionViewCell()
                }
                
                cell.setupData(cellModel: viewModel.getFilteredRestaurantList()[indexPath.row])
                return cell
                
            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuisineCarouselList", for: indexPath)
                        as? CuisineCarouselListCell else {
                    return UICollectionViewCell()
                }
                cell.setupDataModel(dataModel: viewModel.getFilteredCuisineList())
                return cell
            }
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantList", for: indexPath)
                    as? RestaurantListCell else {
                return UICollectionViewCell()
            }
            
            cell.setupData(cellModel: viewModel.getFilteredRestaurantList()[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if viewModel.getFilteredCuisineList().isEmpty && !viewModel.getFilteredRestaurantList().isEmpty{
                return CGSize(width: UIScreen.main.bounds.width - 32, height: RestaurantListCell.getHeight())
            }else{
                return CGSize(width: UIScreen.main.bounds.width, height: CuisineCarouselListCell.getHeight())
            }
        }else{
            return CGSize(width: UIScreen.main.bounds.width - 32, height: RestaurantListCell.getHeight())
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? HomeHeaderView else {
            return UICollectionReusableView()
        }
        if indexPath.section == 0 {
            if viewModel.getFilteredCuisineList().isEmpty && !viewModel.getFilteredRestaurantList().isEmpty{
                //cuisines
                view.setupTitle(title: "Restaurant")
            }else{
                //cuisines
                view.setupTitle(title: "Cuisines")
            }
        }else {
            //restaurant
            view.setupTitle(title: "Restaurant")
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: HomeHeaderView.getHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if viewModel.getFilteredCuisineList().isEmpty && !viewModel.getFilteredRestaurantList().isEmpty{
                viewModel.onRestaurantListCellDidTaped(restaurantCellModel: viewModel.getFilteredRestaurantList()[indexPath.row])
            }else{
                
            }
        }else {
            //restaurant
            viewModel.onRestaurantListCellDidTaped(restaurantCellModel: viewModel.getFilteredRestaurantList()[indexPath.row])
        }
    }
    
    
}
