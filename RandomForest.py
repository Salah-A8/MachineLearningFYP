import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix, roc_curve, auc
from sklearn.preprocessing import label_binarize
from imblearn.over_sampling import SMOTE
import matplotlib.pyplot as plt
from itertools import cycle

dataset = pd.read_csv(r"C:\Users\Salah\Desktop\MachineLearningFYP\CLEANgames.csv") # Loading the dataset from a csv file

features = ['user_reviews', 'price_final', 'price_original', 'mean_hours_played'] # List of selected features from the dataset
x = dataset[features] # Extract feature variables storing it in the x variable
y = dataset['simplified_ratings'] # Extract target variable storing it in the y variable

smote = SMOTE(random_state=2) # SMOTE with a fixed random state for reproducibility
x_smote, y_smote = smote.fit_resample(x, y) # Apply SMOTE to balance class distribution
x_train, x_test, y_train, y_test = train_test_split(x_smote, y_smote, test_size=0.3, stratify=y_smote) # Split the dataset into training and testing sets (70% training, 30% testing) stratified to maintain class distrubtion
randomforest_model = RandomForestClassifier(n_estimators=100, class_weight='balanced') #Creating a random forest model with 100 trees (n estimators) and a balanced class weight for imbalanced data
randomforest_model.fit(x_train, y_train) # Training the Random Forest model on the training data
y_prediction = randomforest_model.predict(x_test) # Letting the Random forest model predict on the testing data

#Model evaluation reports
classification_rep = classification_report(y_test, y_prediction) # Generates a classification report which includes accuracy, precision, f1-score
conf_matrix = confusion_matrix(y_test, y_prediction) # Generates a confusion matrix
print('Classification Report:\n', classification_rep) # Prints classification report
print('Confusion Matrix:\n', conf_matrix) # Prints confusion matrix

labels = randomforest_model.classes_ # Gets the unique class labels from the trained model
y_binarised = label_binarize(y_test, classes=labels) # Converts class labels into binary for ROC curve
y_score = randomforest_model.predict_proba(x_test) # Gets predicted probablites for each class
n_classes = y_binarised.shape[1] # Gets number of classes

FPR = dict() # Dictionary to store False Positive Rates for each class
TPR = dict() # Dictionary to store True Positive Rates for each class
roc_auc = dict() # Dictionary to store AUC values for each class
for i in range(n_classes):
    FPR[i], TPR[i], _ = roc_curve(y_binarised[:, i], y_score[:, i]) # Calculates the FPR and TPR for each class
    roc_auc[i] = auc(FPR[i], TPR[i]) # Calculates AUC for each class

# Plot ROC Curve for each class
plt.figure()
colors = cycle(['aqua', 'darkorange', 'cornflowerblue', 'green', 'red', 'purple'])
for i, color in zip(range(n_classes), colors):
    plt.plot(FPR[i], TPR[i], color=color, lw=2,
             label=f'ROC curve (class {labels[i]}) (area = {roc_auc[i]:0.2f})')

plt.plot([0, 1], [0, 1], 'k--', lw=1) # Plots dashed diagonal line
plt.xlim([0.0, 1.0]) # Sets x axis limits
plt.ylim([0.0, 1.05]) # Sets y axis limits
plt.xlabel('False Positive Rate') # Labels for x axis
plt.ylabel('True Positive Rate') # Labels for y axis
plt.title('Receiver Operating Characteristic (ROC) Curve')
plt.legend(loc="lower right")
plt.grid(True)
plt.show()
