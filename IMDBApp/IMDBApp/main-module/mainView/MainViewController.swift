//
//  MainViewController.swift
//  IMDBApp
//
//  Created by Murat on 26.11.2023.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewGotList = [Movie]()
    var isSearching:Bool = false
    var arananKelime = ""
    
    var justOne = 0
    
    var mainPresenterObject: MainViewToMainPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        
        
        
        //Router
        
        MainRouter.createModule(ref:self)
        
        
        //DegisnOfCollection
 
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width
        
        design.sectionInset = UIEdgeInsets(top: 4, left: 1.5, bottom: 4, right: 1.5)
        design.minimumLineSpacing = 5
        design.minimumInteritemSpacing = 5
        
        let cellWidth = (width-16)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.40)
        collectionView!.collectionViewLayout = design}

        override func viewWillAppear(_ animated: Bool) {
            if arananKelime != ""{
                mainPresenterObject?.toGetMovie(searchedMovie:arananKelime)}
            else{
                if justOne == 0{
                    mainPresenterObject?.toGetMovie(searchedMovie:"Spider-Man")
                    justOne += 1
                }
            }
            
            
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetail"{
                let indeks = sender as! Int
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.imbdID = viewGotList[indeks].imdbID
                
            }
        }
        
    }

//Extension To Get List
extension MainViewController:MainPresenterToMainViewProtocol{
    func sendDataToView(sonuc:Array<Movie>) {
        print("in extension")
        self.viewGotList = sonuc
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("Reload")
        }
        
        
    }
}



//Extension Of CollectionView
extension MainViewController : UICollectionViewDelegate,UICollectionViewDataSource{
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewGotList.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCollectionViewCell
            cell.movieTitleLabel.text = viewGotList[indexPath.row].Title
            
            if let url = URL(string: viewGotList[indexPath.row].Poster!){
                if viewGotList[indexPath.row].Poster == "N/A" {
                    cell.movieImageView.image = UIImage(named: "No_Image_Available")
                }
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url){
                        
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: data)
                        }}
                    else{
                        print("Error loading image data from URL: \(url)")
                    }
                }
                
            }
            
            
            cell.layer.cornerRadius = 16
            cell.clipsToBounds = true



            // Set up shadow
            cell.contentView.layer.cornerRadius = 32.0
            cell.contentView.layer.borderWidth = 2.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true

            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 16.0
            cell.layer.shadowOpacity = 4
            cell.layer.masksToBounds = false

            
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toDetail", sender: indexPath.row)
        }
        
    }
    
    
//Extension Of Searcbar
extension MainViewController : UISearchBarDelegate{
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
                arananKelime = ""
                isSearching = false
            }
        else{
                arananKelime = searchText
                isSearching = true
                self.mainPresenterObject?.toGetMovie(searchedMovie: searchText)
                self.collectionView.reloadData()
            }
        }
    }

